class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy, :notify_availability]
  # GET /cars
  # GET /cars.json
  def index
    @searchflag=1
    if(params[:flag])
      @searchflag=0
    end
    if @searchflag == 0
      @cars = Car.where("location LIKE CASE WHEN ? = ''  THEN '%' ELSE ? END AND model LIKE CASE WHEN ? = ''  THEN '%' ELSE ? END AND manufacturer LIKE CASE WHEN ? = ''  THEN '%' ELSE ? END ", params[:location],params[:location], params[:model],params[:model], params[:manufacturer],params[:manufacturer])
    else 
      @cars =Car.all
    end

    if (current_user.reservations.count == 0)
        @allow_booking = true
    elsif (current_user.reservations.last.current == false)
        @allow_booking = true
    else
        @allow_booking = false
    end

  end

  # GET /cars/1
  # GET /cars/1.json
  def show
   # @car = Car.find(params[:id])
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
   # @car = Car.find(params[:id])
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    #@car = Car.find(params[:id])
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    #@car = Car.find(params[:id])
    if (@car.reservations.count != 0)
      if(@car.reservations.last.current == true)
        respond_to do |format|
          if (@car.status == 'CHECKEDOUT')
          format.html { redirect_to cars_url, notice: 'Car is checkedout. Cant be destroyed' }
          format.json { head :no_content }
          else
            format.html { redirect_to cars_url, notice: 'Car is reserved. Cant be destroyed' }
            format.json { head :no_content }
          end

        end
        return
      end
    end
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def notify_availability
    #@car = Car.find(params[:format])
    @notif= Subscription.new
    @notif.user_id = current_user.id
    @notif.car_id = params[:id]
    @notif.notified=false
    if @notif.save!
   # @car = Car.find(params[:id])
    redirect_to cars_url, notice: 'You will recieve notification when Car : '+ @car.model + ' is available on your register email'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find_by_id(params[:id])
     end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:model, :manufacturer, :license, :rate, :location, :style, :status)
    end
end
