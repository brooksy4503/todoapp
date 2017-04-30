require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
  @user = User.create!(name: "Garth Scaysbrook", email: "brooksy4503@gmail.com",password: "password", password_confirmation: "password")
  @todo = Todo.create(name: "Test Todo Name", description: "Test Todo Description", user: @user)
  end
  
  test "successfully delete a recipe" do
    sign_in_as(@user,"password")
    get todo_path(@todo)
    assert_template 'todos/show'
    assert_difference 'Todo.count', -1 do
      delete todo_path(@todo)
    end
    assert_redirected_to todos_path
    assert_not flash.empty?
  end

end