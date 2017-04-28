class TodosController < ApplicationController
before_action :set_todo, only: [:edit, :update, :show, :destroy]
before_action :require_user, except:[:index]
before_action :require_same_user, only:[:edit,:update,:destroy]

def new
  @todo = Todo.new  
end

def create
  @todo = Todo.new(todo_params)
  @todo.user = current_user
  if @todo.save
    flash[:notice] = "Todo was created successfully!"
  redirect_to todo_path(@todo)
  else
  render 'new'
  end
end

def show
  
end

def edit
  
end

def update
  
  if @todo.update(todo_params)
    flash[:notice] = "Todo was successfully updated"
    redirect_to todo_path(@todo)
  else
    render 'edit'
  end
end

def index
  # @todos = Todo.all
  @todos = Todo.paginate(page: params[:page], per_page: 5)
end

def destroy
  
  @todo.destroy
  flash[:notice] = "Todo was deleted successfully"
  redirect_to todos_path
end

private
def set_todo
  @todo = Todo.find(params[:id])
end

def todo_params
  params.require(:todo).permit(:name, :description)
end

def require_same_user
  if current_user != @todo.user
    flash[:danger] = "You can only edit and delete your own todos"
    redirect_to todos_path
  end
end

end
