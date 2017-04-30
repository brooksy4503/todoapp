require 'test_helper'

class TodosTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(name: "Garth Scaysbrook", email: "brooksy4503@gmail.com", password: "password", password_confirmation: "password")
    @todo = Todo.create(name: "Garth 1st Test", description: "Test Description", user: @user)
    @todo2 = @user.todos.build(name: "Garth 2nd Test", description: "Test Description")
    @todo2.save
  end
  
  test "should get todos index" do
    get todos_path
    assert_response :success
  end
  
  test "should get todos listing" do
    get todos_path
    assert_template 'todos/index'
    assert_match @todo.name, response.body
    assert_match @todo2.name, response.body
  end
  
  test "should get todos show" do
    sign_in_as(@user,"password")
    get todo_path(@todo)
    assert_template 'todos/show'
    assert_match @todo.name, response.body
    assert_match @todo.description, response.body
    assert_match @user.name, response.body
  end
  
  test "create a new valid todo" do
    sign_in_as(@user,"password")
    get new_todo_path
    assert_template 'todos/new'
    name_of_todo = "Test Todo"
    description_of_todo = "Test Description"
    assert_difference 'Todo.count', 1 do
    post todos_path, params: { todo: { name: name_of_todo, description: description_of_todo}}
    end
    follow_redirect!
    assert_match name_of_todo, response.body
    assert_match description_of_todo, response.body
  end
  
  test "reject an invalid todo submission" do
    sign_in_as(@user,"password")
    get new_todo_path
    assert_template 'todos/new'
    assert_no_difference 'Todo.count' do
      post todos_path, params: { todo: { name: " ", description: " " }}
    end
    assert_template 'todos/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end




end
