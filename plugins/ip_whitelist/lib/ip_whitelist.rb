module IpWhitelist
  def self.included(base) #:nodoc:
    base.extend(ClassMethods)
  end

  module ClassMethods
    def whitelist #:nodoc:
      @whitelist ||= []
    end

    # Limit controller action access to remote IPs specified in the whitelist.
    # Accepts all the standard before_filter options (:except, :only, etc)
    #
    # Example:
    #
    #   allow_from_ip ["192.168.0.1", "192.168.0.2"], :except => [:index, :show]
    def allow_from_ip(access_list, options = {})
      whitelist.concat(access_list)
      before_filter(:check_whitelist, options)
    end
  end

  def whitelist #:nodoc:
    self.class.whitelist
  end

  def check_whitelist #:nodoc:
    if whitelist.include?(request.remote_ip)
      true
    else
      logger.error("WHITELIST: ACCESS DENIED FOR [#{request.remote_ip}]")
      render(:nothing => true, :status => 401)
      false
    end
  end
end

