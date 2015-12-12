class UsersController < ApplicationController
  def index
    respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @user.errors }
    end
  end
  
  
  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        format.html { }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors }
      end
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email)
  end  
  
end
