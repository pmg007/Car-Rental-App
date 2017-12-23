class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  include ReservationsHelper
  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @checkout_for_user = false
    if (current_user.role != 'customer' && @reservation.current == true)
      @checkout_for_user = true
    end
  end
  
  # GET /reservations/new
  def new
    @reservation = current_user.reservations.build
    @flag=false
  end

  # GET /reservations/1/edit
  def edits
    @reservation=Reservation.find(params[:id])
    @car = @reservation.car_id
    @flag = true
  end

  def checkout_reservation
    @reservation = Reservation.find(params[:format])
    if (@reservation.checkout > Time.now)
      redirect_to home_dashboard_path ,notice: 'Car can not be checked out before the check out time.'
      return
    end

    if (@reservation.checkout + 30.minutes < Time.now)
      redirect_to home_dashboard_path ,notice: 'Your reservation has expired'
      return
    end

    @car = Car.find_by_id(@reservation.car_id)
    if @car == nil
      redirect_to home_dashboard_path, notice: 'This Car not found'
      return
    end
    if (@car.status == "RESERVED"  )
         @car.status = "CHECKEDOUT"
         if @car.save!
    #if @reservation.checkout?
          redirect_to home_dashboard_path , notice: 'Car has been checkedout.'

         end
    else
      redirect_to home_dashboard_path, notice: 'Car was not successfully checkedout.'
    end
  end

  def checkin_reservation
    @reservation = Reservation.find(params[:format])
    @car = Car.find_by_id(@reservation.car_id)
    if @car == nil
      redirect_to home_dashboard_path, notice: 'This Car not found'
      return
    end
    if (@car.status == "CHECKEDOUT")
      @car.status = "AVAILABLE"
      @reservation.update(current: false, checkin: DateTime.now)

      if (@car.save! && @reservation.save!)
        #if @reservation.checkout?
        @subs=Subscription.where(car_id: @car.id)
        @subs.each do |sub|
          if sub.notified == false
            @us=User.find(sub.user_id)
            QMailMailer.avail_email(@us).deliver_now
            sub.notified=true
            sub.save!
          end
        end
        redirect_to @reservation, notice: 'Your car was checkedin.'
      end
    else
      redirect_to home_dashboard_path, notice: 'Car is not yet checkedout'
    end
  end

  def cancel_reservation
    @reservation = Reservation.find(params[:format])
    @car = Car.find_by_id(@reservation.car_id)
    if @car == nil
        redirect_to home_dashboard_path, notice: 'This Car not found'
        return
    end
    if (@car.status == "CHECKEDOUT")
      redirect_to home_dashboard_path, notice: 'This Car is checkedout. Booking can not be cancelled'
      return
    end
    if (@reservation.checkout > Time.now)
     @car.update(status: "AVAILABLE")
     @reservation.update(current: false)
     if (@car.save! && @reservation.save!)
      @subs=Subscription.where(car_id: @car.id)
        @subs.each do |sub|
          if sub.notified == false
            @us=User.find(sub.user_id)
            QMailMailer.avail_email(@us).deliver_now
            sub.notified=true
            sub.save!
          end
        end
       redirect_to home_dashboard_path, notice: 'Your booking is canceled successfully'
     else
       redirect_to home_dashboard_path, notice: 'error!! Your booking was not canceled'
     end
    else
      redirect_to home_dashboard_path, notice: 'Cannot cancel the booking. Checkout the car or the booking will expire'
    end
  end

  # POST /reservations
  # POST /reservations.json
  def create
  #  if (current_user != 'customer')
  #   @reservation = Reservation.new
  # # @user = User.find_by_email(params[:email])
  #   #   # logger.debug"@@@@@@@@@#{@r.inspect}"
  #    @call =User.find_by_email(params[:email])
  #     @reservation.checkout = params[:checkout]
  # @reservation.car_id = params[:car_id]
  #   @reservation.hours = params[:hours]
  #  @reservation.user_id =3
    #else
    @reservation = current_user.reservations.new(reservation_params)

    @reservation.current = true

    respond_to do |format|
      if overlap?(@reservation)

          format.html { redirect_to new_reservation_path(:car_id => @reservation.car_id), notice: 'Reservation time is overlapping with a previous reservation. please select another time'}
      elsif @reservation.save
        @reservation.car.status= "RESERVED"
        @reservation.car.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end
 def new_for_user
   #render form_for_user
   @reservation = current_user.reservations.build
   @flag=false
 end
  def create_for_user

  end
  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { redirect_to edit_reservation_path}
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_history
    @user=User.find(params[:format])
    @reservations = @user.reservations
    #@reservations.each do |f|
    #@car = Cars.find(f.car_id)
    #end
  end
  def overlap?(reservation)
    id=reservation.car_id
    @rer = Reservation.where(["car_id = ? and current = 't'",id])
    if @res != nil
    @rer.each do |r|
      if (reservation.checkout < r.checkout)
        if (reservation.checkout+(reservation.hours).hours > r.checkout)
          return true
        end
      elsif (reservation.checkout < r.checkout+(r.hours).hours)
        return true
      end
    end
    end
    return false
  end

  def billing
    @reservation = @reservation = Reservation.find(params[:id])

  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:checkin, :checkout , :car_id, :hours, :current, :email)
    end

end


