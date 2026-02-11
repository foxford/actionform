require 'test_helper'

class ConferencesControllerTest < ActionController::TestCase
  fixtures :conferences, :speakers, :presentations

  setup do
    @conference = conferences(:ruby)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conference" do
    assert_difference(['Conference.count', 'Speaker.count']) do
      post :create, params: { conference: {
        name: "Euruco",
        city: "Athens",

        speaker_attributes: {
          name: "Petros Markou",
          occupation: "Developer",

          presentations_attributes: {
            "0" => { topic: "Ruby OOP", duration: "1h" },
            "1" => { topic: "Ruby Closures", duration: "1h" },
          }
        }
      } }
    end

    conference = Conference.last
    assert_equal "Euruco", conference.name
    assert_equal "Athens", conference.city
    assert_equal "Petros Markou", conference.speaker.name
    assert_equal "Developer", conference.speaker.occupation
    assert_equal 2, conference.speaker.presentations.size

    assert_redirected_to conference_path(conference)
    assert_match /was successfully created/, flash[:notice]
  end

  test "should create dynamically added presentation to speaker" do
    assert_difference('Conference.count') do
      post :create, params: { conference: {
        name: "Euruco",
        city: "Athens",

        speaker_attributes: {
          name: "Petros Markou",
          occupation: "Developer",

          presentations_attributes: {
            "0" => { topic: "Ruby OOP", duration: "1h" },
            "1" => { topic: "Ruby Closures", duration: "1h" },
            "12312" => { topic: "Ruby Metaprogramming", duration: "2h" }
          }
        }
      } }
    end

    conference = Conference.last
    assert_equal 3, conference.speaker.presentations.size

    assert_redirected_to conference_path(conference)
    assert_match /was successfully created/, flash[:notice]
  end

  test "should not create conference with invalid params" do
    assert_difference(['Conference.count', 'Speaker.count'], 0) do
      post :create, params: { conference: {
        name: @conference.name,
        city: nil,

        speaker_attributes: {
          name: @conference.speaker.name,
          occupation: "Developer",

          presentations_attributes: {
            "0" => { topic: nil, duration: "1h" },
            "1" => { topic: "Ruby Closures", duration: nil },
          }
        }
      } }
    end

    assert_response :success
  end

  test "should show conference" do
    get :show, params: { id: @conference }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @conference }
    assert_response :success
  end

  test "should update conference" do
    assert_difference('Conference.count', 0) do
      patch :update, params: { id: @conference, conference: {
        name: "GoGaruco",
        city: "Golden State",

        speaker_attributes: {
          name: "John Doe",
          occupation: "Developer",

          presentations_attributes: {
            "0" => { topic: "Rails OOP", duration: "1h", id: presentations(:ruby_oop).id },
            "1" => { topic: "Rails Patterns", duration: "1h", id: presentations(:ruby_closures).id },
          }
        }
      } }
    end

    @conference.reload
    assert_equal "GoGaruco", @conference.name
    assert_equal "Golden State", @conference.city
    assert_equal "John Doe", @conference.speaker.name

    assert_redirected_to conference_path(@conference)
    assert_match /was successfully updated/, flash[:notice]
  end

  test "should destroy dynamically removed presentation from speaker" do
    assert_difference('Presentation.count', -1) do
      patch :update, params: { id: @conference, conference: {
        name: "GoGaruco",
        city: "Golden State",

        speaker_attributes: {
          name: "John Doe",
          occupation: "Developer",

          presentations_attributes: {
            "0" => { topic: "Rails OOP", duration: "1h", id: presentations(:ruby_oop).id },
            "1" => { topic: "Rails Patterns", duration: "1h", id: presentations(:ruby_closures).id, _destroy: "1" },
          }
        }
      } }
    end

    @conference.reload
    assert_equal 1, @conference.speaker.presentations.size

    assert_redirected_to conference_path(@conference)
    assert_match /was successfully updated/, flash[:notice]
  end

  test "should destroy conference" do
    assert_difference('Conference.count', -1) do
      delete :destroy, params: { id: @conference }
    end

    assert_redirected_to conferences_path
  end
end
