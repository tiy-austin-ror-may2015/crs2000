require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @company = Company.create(name: 'foo-llc')
    @employee = Employee.create(email: 'user@example.com', password: 'foobar', company_id: @company.id)
    @request.env["devise.mapping"] = Devise.mappings[:employee]
    @controller.stubs(:current_employee).returns(@employee)
    sign_in @employee
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, company: { name: @company.name }
    end

    assert_redirected_to company_path(assigns(:company))
  end

  test "should show company" do
    get :show, id: @company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company
    assert_response :success
  end

  test "should update company" do
    patch :update, id: @company, company: { name: @company.name }
    assert_redirected_to company_path(assigns(:company))
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete :destroy, id: @company
    end

    assert_redirected_to companies_path
  end
end
