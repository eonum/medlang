require 'test_helper'

class LearnSessionsControllerTest < ActionController::TestCase
  setup do
    @learn_session = learn_sessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:learn_sessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create learn_session" do
    assert_difference('LearnSession.count') do
      post :create, learn_session: {  }
    end

    assert_redirected_to learn_session_path(assigns(:learn_session))
  end

  test "should show learn_session" do
    get :show, id: @learn_session
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @learn_session
    assert_response :success
  end

  test "should update learn_session" do
    patch :update, id: @learn_session, learn_session: {  }
    assert_redirected_to learn_session_path(assigns(:learn_session))
  end

  test "should destroy learn_session" do
    assert_difference('LearnSession.count', -1) do
      delete :destroy, id: @learn_session
    end

    assert_redirected_to learn_sessions_path
  end
end
