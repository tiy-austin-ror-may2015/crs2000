require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
  setup do
    company  = Company.create(name: 'foobar')
    @room    = Room.create(name: Faker::Name.last_name,
                  max_occupancy: Faker::Number.number(2),
                    room_number: Faker::PhoneNumber.area_code,
                         imgurl: "",
                       location: Faker::App.name,
                     company_id: company.id)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rooms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room" do
    assert_difference('Room.count') do
      post :create, room: { imgurl: @room.imgurl, location: @room.location, max_occupancy: @room.max_occupancy, name: @room.name, room_number: @room.room_number }
    end

    assert_redirected_to room_path(assigns(:room))
  end

  test "should show room" do
    get :show, id: @room
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @room
    assert_response :success
  end

  test "should update room" do
    patch :update, id: @room, room: { imgurl: @room.imgurl, location: @room.location, max_occupancy: @room.max_occupancy, name: @room.name, room_number: @room.room_number }
    assert_redirected_to room_path(assigns(:room))
  end

  test "should destroy room" do
    assert_difference('Room.count', -1) do
      delete :destroy, id: @room
    end

    assert_redirected_to rooms_path
  end
end
