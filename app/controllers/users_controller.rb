class UsersController < ApplicationController
before_action :set_user, only: [:edit, :update, :show, :destroy]
before_action :require_same_user, only: [:edit, :update,  :destroy]
before_action :require_admin, only: [:destroy]
before_action :require_user

def new
  @user = User.new
end

def create
  @user = User.new(user_params)  
  if @user.save
    session[:user_id] = @user.id
    flash[:success] = "Your Profile was created successfully!"
    redirect_to user_path(@user)
  else
    render 'new'
  end
end

def show
    @user_todos = @user.todos.paginate(page: params[:page], per_page: 5)
    # @user_todos = Todo.where(user_id: @user.id).paginate(page: params[:page], per_page: 5)
end

def edit
  
end

def update
  if @user.update(user_params)
    flash[:success] = "User was successfully updated"
    redirect_to user_path(@user)
  else
    render 'edit'
  end  

end

def index
  # @users = User.all
  if current_user.admin?
  @users = User.paginate(page: params[:page], per_page: 5)
  else
  @users = User.where(id: current_user.id).paginate(page: params[:page], per_page: 5)
  end
   

  
end

def destroy
    if !@user.admin?
      @user.destroy
      flash[:danger] = "Chef and all associated recipes have been deleted"
      redirect_to users_path
    end
end

private
def set_user
  @user = User.find(params[:id])
end
def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end

def require_same_user
  if current_user != @user and !current_user.admin?
    flash[:danger] = "You can only edit and delete your own account"
    redirect_to users_path
  end
end

def require_admin
    if logged_in? && !current_user.admin? && !user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
      
    end
end
  
end
  
  