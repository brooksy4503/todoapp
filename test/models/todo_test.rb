require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(name: "Garth Scaysbrook", email: "brooksy4503@gmail.com", password: "password", password_confirmation: "password")
    @todo = @user.todos.build(name: "Garth's test Todo", description: "test description")
  end
  
  test "todo without user should be invalid" do
    @todo.user_id = nil
    assert_not @todo.valid?
  end
  
  test "todo should be valid" do
    assert @todo.valid?
  end
  
  test "name should be present" do
    @todo.name = ""
    assert_not @todo.valid?
  end
  
  test "description should be present" do
    @todo.description = ""
    assert_not @todo.valid?
  end
  
  test "description shouldn't be less than 5 characters" do
    @todo.description = "a" * 3
    assert_not @todo.valid?
  end
  
  test "description shouldn't be more than 500 characters" do
    @todo.description = "a" * 501
    assert_not @todo.valid?
  end
end
