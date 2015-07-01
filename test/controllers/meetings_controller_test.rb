require 'test_helper'
class TestDel
  def deliver_now
  end
end
class MeetingMailer
  def self.method_missing(*args, &block)
    TestDel.new
  end
end

class MeetingsControllerTest < ActionController::TestCase
  setup do
    company = Company.create!(name: 'foobar')
    room    = Room.create!(name: Faker::Name.last_name,
                  max_occupancy: Faker::Number.number(2),
                    room_number: Faker::PhoneNumber.area_code,
                         imgurl: "",
                       location: Faker::App.name,
                     company_id: company.id)
    password = Faker::Internet.password
    @employee = Employee.create!(name: Faker::Name.name,
                              email: Faker::Internet.safe_email,
                           password: password,
              password_confirmation: password,
                         company_id: company.id)
    @meeting = Meeting.create!(title: Faker::Company.bs,
                             agenda: Faker::Lorem.paragraph,
                         start_time: (Time.now + 10.hours),
                           end_time: (Time.now + 15.hours),
                            room_id: room.id, employee_id: @employee.id)

    @request.env["devise.mapping"] = Devise.mappings[:employee]
    @controller.stubs(:current_employee).returns(@employee)
    sign_in @employee
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meetings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meeting" do
    assert_difference('Meeting.count') do
      post :create, meeting: { agenda: @meeting.agenda, end_time: (@meeting.end_time + 100.hours), start_time: (@meeting.start_time + 100.hours), title: @meeting.title, room_id: @meeting.room.id}
    end

    assert_redirected_to meeting_path(assigns(:meeting))
  end

  test "should show meeting" do
    get :show, id: @meeting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meeting
    assert_response :success
  end

  test "should update meeting" do
    patch :update, id: @meeting, meeting: { agenda: @meeting.agenda, end_time: @meeting.end_time, start_time: @meeting.start_time, title: @meeting.title }
    assert_redirected_to meeting_path(assigns(:meeting))
  end

  test "should destroy meeting" do
    assert_difference('Meeting.count', -1) do
      delete :destroy, id: @meeting
    end

    assert_redirected_to meetings_path
  end
end
