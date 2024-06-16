class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    email = params[:email].downcase.strip
    if user = User.find_by_email(params[email])
      redirect_to '/signup'
    else
      user = User.new(user_params)
      if user.save
       session[:user_id] = user.id
       redirect_to '/'
     else
       redirect_to '/signup'
     end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end