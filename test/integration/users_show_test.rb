require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  
    def setup
      @user = User.create!(name: "Garth Scaysbrook", email: "brooksy4503@gmail.com", password: "password",
                          password_confirmation: "password")
      @todo = Todo.create(name: "Test Todo Name", description: "Test Todo Description",
                              user: @user)
      @todo2 = @user.todos.build(name: "Test Todo Name 2", description: "Test Todo Description 2")
      @todo2.save
    end
    
    test "should get users show" do
      
      get user_path(@user)
      assert_template 'users/show'
      assert_select "a[href=?]", todo_path(@todo), text: @todo.name
      assert_select "a[href=?]", todo_path(@todo2), text: @todo2.name
      assert_match @todo.description, response.body
      assert_match @todo2.description, response.body
      assert_match @user.name, response.body
      
    end
  

end
