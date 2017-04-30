require 'test_helper'

class UsersListingTest < ActionDispatch::IntegrationTest

  def setup
      @user = User.create!(name: "Garth Scaysbrook", email: "brooksy4503@gmail.com", password: "password", password_confirmation: "password")
      @user2 = User.create!(name: "Bob Jones", email: "bob@example.com", password: "password", password_confirmation: "password")
      @admin_user = User.create!(name: "Tom Jones", email: "admin@example.com", password: "password", password_confirmation: "password", admin: true)
  end  
  
  test "should get user listing" do
    get users_path
    assert_template 'users/index'
    # assert_select "a[href=?]", user_path(@user), text: @user.name
    # assert_select "a[href=?]", user_path(@user2), text: @user2.name
  end
  
  test "should delete user" do
    sign_in_as(@admin_user,"password")
    get users_path
    assert_template 'users/index'
    assert_difference 'User.count', -1 do
      delete user_path(@user2)
    end
    assert_redirected_to users_path
    assert_not flash.empty?
  end
end
