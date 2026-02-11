require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  fixtures :users, :emails, :profiles

  setup do
    @user = users(:peter)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference(['User.count', 'Email.count', 'Profile.count']) do
      post :create, params: { user: {
        age: "23",
        gender: "0",
        name: "petrakos",

        email_attributes: {
          address: "petrakos@gmail.com"
        },

        profile_attributes: {
          twitter_name: "t_peter",
          github_name: "g_peter"
        }
      } }
    end

    user = User.last
    assert_equal "petrakos", user.name
    assert_equal 23, user.age
    assert_equal 0, user.gender
    assert_equal "petrakos@gmail.com", user.email.address
    assert_equal "t_peter", user.profile.twitter_name
    assert_equal "g_peter", user.profile.github_name

    assert_redirected_to user_path(user)
    assert_match /was successfully created/, flash[:notice]
  end

  test "should not create user with invalid params" do
    assert_difference(['User.count', 'Email.count', 'Profile.count'], 0) do
      post :create, params: { user: {
        name: @user.name,
        age: nil,
        gender: "0",

        email_attributes: {
          address: @user.email.address
        },

        profile_attributes: {
          twitter_name: @user.profile.twitter_name,
          github_name: @user.profile.github_name
        }
      } }
    end

    assert_response :success
  end

  test "should show user" do
    get :show, params: { id: @user }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @user }
    assert_response :success
  end

  test "should update user" do
    assert_difference(['User.count', 'Email.count', 'Profile.count'], 0) do
      patch :update, params: { id: @user, user: {
        age: @user.age,
        gender: @user.gender,
        name: "petrakos",

        email_attributes: {
          address: "petrakos@gmail.com"
        },

        profile_attributes: {
          twitter_name: "t_peter",
          github_name: "g_peter"
        }
      } }
    end

    @user.reload
    assert_equal "petrakos", @user.name
    assert_equal "petrakos@gmail.com", @user.email.address
    assert_equal "t_peter", @user.profile.twitter_name
    assert_equal "g_peter", @user.profile.github_name

    assert_redirected_to user_path(@user)
    assert_match /was successfully updated/, flash[:notice]
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, params: { id: @user }
    end

    assert_redirected_to users_path
  end
end
