class HomeController < ApplicationController
  def index
  	if user_signed_in?
      redirect_to home_dashboard_path
    end
  end

  def dashboard

    @res=Reservation.where(current: true)
    if( @res != nil)
    @res.each do |resr|
      if resr.checkout+30.minutes<Time.now
        user=User.find(resr.user_id)
        resr.checkin=resr.checkout+30.minutes
        resr.current=false
        resr.save!
        @car=Car.find(resr.car_id)
        @user=User.find(resr.user_id)
        @car.status="AVAILABLE"
        @car.save!
        QMailMailer.timeout_email(@user).deliver_now

      end
    end
      end
  end

  def checkoutpage
 	@time=current_user.reservations.last.checkout
 	if(@time>Time.now && @time<Time.now+30.minutes)
 			render :template=>"home/checkoutpage.html.erb"
 	else
 		flash[:error] = 'Your checkout is not ready as yet.'
 		render :template=>"home/dashboard" ,:locals=>{:msg=>"jk"}
 		
 		
 	end

  end

end
