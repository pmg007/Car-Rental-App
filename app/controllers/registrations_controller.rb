class RegistrationsController < Devise::RegistrationsController

  def display
    @users=User.all
  end

  def new
  	@user=User.new
  end

  def new1
    @user=User.new
  end

  def show
    @user=User.find(params[:format])
  end

  def edituser

   logger.debug"@@@@@@@@@#{params.inspect}"
   # :id=params{:format}
    @user=User.find(params[:format])
  end

  def create_user
    @user = User.new(new_user_params)
    if @user.save
      redirect_to user_display_path, notice: 'User was successfully created.'
    else
      render :new1
    end
  end

  def destroy
    @user=User.find(params[:format])

    if (@user.reservations.count != 0)
      if(@user.reservations.last.current == true)
           redirect_to user_display_path, notice: 'User has reservation. Cant be destroyed'
        return
      end
    end
    @reservations = @user.reservations
    @reservations.each do |r|
        @reservations.destroy
    end

    @user.destroy
    # respond_to do |format|
    redirect_to user_display_path, notice: 'User was successfully destroyed.'
    # format.json { head :no_content }
  end


  private

  def sign_up_params
    params.require(:user).permit(:name, :role, :email, :password, :password_confirmation, :rental)
  end

  def new_user_params
    params.require(:user).permit(:name, :role, :email, :password, :password_confirmation, :rental)
  end

  def account_update_params
    params.require(:user).permit(:name, :role, :email, :password, :password_confirmation, :current_password, :id)
  end
end

