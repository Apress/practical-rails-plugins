# Enhanced by cpatil - at - gmail.com
#
module ScottBarron
  module Acts
    module StateMachine 
      class NoNextState < Exception #:nodoc:
      end
      module SupportingClasses
        class Event
          def fire(record, *args)
            ret_val = nil
            next_states(record).each do |transition|
              performed, ret_val = transition.perform(record, *args)
              break [true, ret_val] if performed
            end
          end
        end
        class StateTransition
          def initialize(opts)
            @from, @guard, @on_transition = opts[:from].to_sym, opts[:guard], opts[:on_transition]
            if opts[:to].is_a?(Array)
              @to = opts[:to].collect {|s| s.to_sym}
            else
              @to = opts[:to].to_sym
            end
            @opts = opts
          end

          def on_transition(obj, *args)
            @on_transition ? obj.send(:run_transition_action, @on_transition, *args) : nil
          end

          def perform(record, *args)
            return false unless guard(record)
            isarr = to.is_a?(Array)
            if isarr
              raise NoNextState unless args.length && args.last.is_a?(Hash) && args.last[:next_state]
            end              

            if isarr
              loopback = to.include?(record.current_state)
            else
              loopback = record.current_state == to.to_sym
            end
            states = record.class.read_inheritable_attribute(:states)

            if isarr
              tonew = args.pop[:next_state].to_sym
              next_state = states[tonew.to_sym]
              raise NoNextState unless next_state              
            else
              tonew = self.to.to_sym 
              next_state = states[tonew]
            end
            old_state = states[record.current_state.to_sym]

            ret_val = on_transition(record, *args)
            next_state.entering(record) unless loopback
          
            record.update_attribute(record.class.state_column, tonew.to_s)
          
            next_state.entered(record) unless loopback
            old_state.exited(record) unless loopback
            [true, ret_val]
          end
          
          def ==(obj)
            if @to.is_a?(Array)
              return @from == obj.from && @to.include?(obj.to)
            else
              return @from == obj.from && @to == obj.to
            end
          end
        end
      end      
      module ClassMethods
        def event(event, opts={}, &block)
          tt = read_inheritable_attribute(:transition_table)
          
          et = read_inheritable_attribute(:event_table)
          e = et[event.to_sym] = SupportingClasses::Event.new(event, opts, tt, &block)
          define_method("#{event.to_s}!") { |*args| e.fire(self,*args) }
        end
      end
      module InstanceMethods        
        def run_transition_action(action, *args)
          Symbol === action ? self.method(action).call(*args) : action.call(self, *args)
        end
        
        # Returns what the next state for a given event would be, as a Ruby symbol.
        def next_state_for_event(event)
          ns = next_states_for_event(event)
          # cp ?
          ns.empty? ? nil : ns.first.to
        end

        def next_events_for_current_state
          events = []  
          self.class.read_inheritable_attribute(:event_table).each do |eventName,eventVal|
            eventVal.instance_variable_get(:@transitions).each do |transition|
              events << eventName if transition.from == current_state()  
            end
          end
          events.uniq
        end          
      end
    end
  end
end
