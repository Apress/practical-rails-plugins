class CarsController < ApplicationController
  def index
    @cars = Car.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @cars }
    end
  end
  def show
    @car = Car.find(params[:id])
    @car_history = @car.versions
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => {'current'=>@car,
                                    'history'=>@car_history }}
    end
  end
  def new
    @car = Car.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @car }
    end
  end
  def create
    @car = Car.new(params[:car])
    respond_to do |format|
      if @car.save
        flash[:notice] = 'Car was successfully created.'
        format.html { redirect_to(@car) }
        format.xml { render :xml => @car, :status => :created, :location => @car }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @car.errors, :status => :unprocessable_entity }
      end
    end
  end
  def update
    @car = Car.find(params[:id])
    respond_to do |format|
      if @car.update_attributes(params[:car])
        flash[:notice] = 'Car was successfully updated.'
        format.html { redirect_to(@car) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @car.errors, :status => :unprocessable_entity }
      end
    end
  end
  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    respond_to do |format|
      format.html { redirect_to(cars_url) }
      format.xml { head :ok }
    end
  end
end

