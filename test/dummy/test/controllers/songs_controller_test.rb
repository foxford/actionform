require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  fixtures :songs, :artists, :producers

  setup do
    @song = songs(:lockdown)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create song" do
    assert_difference(['Song.count', 'Artist.count', 'Producer.count']) do
      post :create, params: { song: {
        title: "Diamonds",
        length: "360",

        artist_attributes: {
          name: "Karras",

          producer_attributes: {
            name: "Phoebos",
            studio: "MADog"
          }
        }
      } }
    end

    song = Song.last
    assert_equal "Diamonds", song.title
    assert_equal "360", song.length
    assert_equal "Karras", song.artist.name
    assert_equal "Phoebos", song.artist.producer.name
    assert_equal "MADog", song.artist.producer.studio

    assert_redirected_to song_path(song)
    assert_match /was successfully created/, flash[:notice]
  end

  test "should not create song with invalid params" do
    assert_difference(['Song.count', 'Artist.count', 'Producer.count'], 0) do
      post :create, params: { song: {
        title: nil,
        length: nil,

        artist_attributes: {
          name: nil,

          producer_attributes: {
            name: nil,
            studio: nil
          }
        }
      } }
    end

    assert_response :success
  end

  test "should show song" do
    get :show, params: { id: @song }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @song }
    assert_response :success
  end

  test "should update song" do
    assert_difference(['Song.count', 'Artist.count', 'Producer.count'], 0) do
      patch :update, params: { id: @song, song: {
        title: "Run this town",
        length: "355",

        artist_attributes: {
          name: "Rihanna",

          producer_attributes: {
            name: "Eminem",
            studio: "Marshall"
          }
        }
      } }
    end

    @song.reload
    assert_equal "Run this town", @song.title
    assert_equal "355", @song.length
    assert_equal "Rihanna", @song.artist.name
    assert_equal "Eminem", @song.artist.producer.name
    assert_equal "Marshall", @song.artist.producer.studio

    assert_redirected_to song_path(@song)
    assert_match /was successfully updated/, flash[:notice]
  end

  test "should destroy song" do
    assert_difference('Song.count', -1) do
      delete :destroy, params: { id: @song }
    end

    assert_redirected_to songs_path
  end
end
