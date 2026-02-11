require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase
  fixtures :assignments, :tasks

  setup do
    @assignment = assignments(:yard)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assignment" do
    assert_difference('Assignment.count', 1) do
      assert_difference('Task.count', 3) do
        post :create, params: { assignment: {
          name: "Life",

          tasks_attributes: {
            "0" => { name: "Eat" },
            "1" => { name: "Pray" },
            "2" => { name: "Love" },
          }
        } }
      end
    end

    assignment = Assignment.last
    assert_equal "Life", assignment.name
    assert_equal 3, assignment.tasks.size

    assert_redirected_to assignment_path(assignment)
    assert_match /was successfully created/, flash[:notice]
  end

  test "should not create assignment with invalid params" do
    assert_difference('Assignment.count', 0) do
      post :create, params: { assignment: {
        name: @assignment.name,

        tasks_attributes: {
          "0" => { name: nil },
          "1" => { name: nil },
          "2" => { name: nil },
        }
      } }
    end

    assert_response :success
  end

  test "should show assignment" do
    get :show, params: { id: @assignment }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @assignment }
    assert_response :success
  end

  test "should update assignment" do
    assert_difference('Assignment.count', 0) do
      patch :update, params: { id: @assignment, assignment: {
        name: "Car service",

        tasks_attributes: {
          "0" => { name: "Wash tires", id: tasks(:rake).id },
          "1" => { name: "Clean inside", id: tasks(:paint).id },
          "2" => { name: "Check breaks", id: tasks(:clean).id },
        }
      } }
    end

    @assignment.reload
    assert_equal "Car service", @assignment.name

    assert_redirected_to assignment_path(@assignment)
    assert_match /was successfully updated/, flash[:notice]
  end

  test "should destroy assignment" do
    assert_difference('Assignment.count', -1) do
      delete :destroy, params: { id: @assignment }
    end

    assert_redirected_to assignments_path
  end
end
