require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Garth Scaysbrook", email: "brooksy4503@gmail.com",password: "password",
                          password_confirmation: "password")
    @user2 = User.create!(name: "john", email: "john@example.com",password: "password",
                          password_confirmation: "password")
    @admin_user = User.create!(name: "john1", email: "john1@example.com.com",password: "password",
                          password_confirmation: "password", admin: true)
  end
   
  test "reject an invalid edit" do
    sign_in_as(@user,"password")
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: " ", email: "brooksy4503@gmail.com"}}
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "Accept valid edit" do
      sign_in_as(@user,"password")
      get edit_user_path(@user)
      assert_template 'users/edit'
      patch user_path(@user), params: { user: { name: "Garth Scaysbrook", email: "brooksy4503@gmail.com" } }
      assert_redirected_to @user
      assert_not flash.empty?
      @user.reload
      assert_match "Garth Scaysbrook", @user.name
      assert_match "brooksy4503@gmail.com", @user.email

  
  end
  
  test "accept edit attempt by admin user" do
      sign_in_as(@admin_user,"password")
      get edit_user_path(@user)
      assert_template 'users/edit'
      patch user_path(@user), params: { user: { name: "garth2", email: "garth2@example.com" } }
      assert_redirected_to @user
      assert_not flash.empty?
      @user.reload
      assert_match "garth2", @user.name
      assert_match "garth2@example.com", @user.email    
    
  end
  
  test "redirect edit attempt by another non-admin user" do
      sign_in_as(@user2,"password")
      updated_name = "joe"
      updated_email = "joe@example.com"
      patch user_path(@user), params: { user: { name: updated_name, email: updated_email } }
      assert_redirected_to users_path
      assert_not flash.empty?
      @user.reload
      assert_match "Garth Scaysbrook", @user.name
      assert_match "brooksy4503@gmail.com", @user.email        
  end
end
