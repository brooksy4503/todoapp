require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Garth Scaysbrook", email: "brooksy4503@gmail.com",password: "password", password_confirmation: "password")
    @todo = Todo.create(name: "Test Todo Name", description: "Test Todo Description", user: @user)
  end  
  
  test "reject invalid recipe update" do
    sign_in_as(@user,"password")
    get edit_todo_path(@todo)
    assert_template 'todos/edit'
    patch todo_path(@todo), params: { todo: { name: " ", description: "some description"} }
    assert_template 'todos/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end 
  
  test "successfully edit a recipe" do
    sign_in_as(@user,"password")
    get edit_todo_path(@todo)
    assert_template 'todos/edit'
    updated_name = "updated todo name"
    updated_description = "updated todo description"
    patch todo_path(@todo), params: { todo: {name: updated_name, description: updated_description}}
    assert_redirected_to @todo
    #follow_redirect!
    assert_not flash.empty?
    @todo.reload
    assert_match updated_name, @todo.name
    assert_match updated_description, @todo.description
  end

end