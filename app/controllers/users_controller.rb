class UsersController < ApplicationController
before_action :set_user, only: [:edit, :update, :show, :destroy]

def new
  @user = User.new
end

def create
  @user = User.new(user_params)  
  if @user.save
    flash[:notice] = "Todo was created successfully!"
  redirect_to user_path(@user)
  else
  render 'new'
  end
end

def show
  
end

def edit
  
end

def update
  if @user.update(user_params)
    flash[:notice] = "User was successfully updated"
    redirect_to user_path(@user)
  else
    render 'edit'
  end  

end

def index
  @users = User.all
end

def destroy

end

private
def set_user
  @user = User.find(params[:id])
end
def user_params
  params.require(:user).permit(:name, :email)
end
  
end
  
  