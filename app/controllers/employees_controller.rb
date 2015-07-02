class EmployeesController < ApplicationController

  def index
    @employees = Employee.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @employee = Employee.find(params[:id])
    @next_meeting = @employee.confirmed_meetings.order(:start_time).limit(1).first
  end


  def edit
    @employee = Employee.find(params[:id])
  end

  def update
  @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to @employee, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  def employee_search
    @employee_results = Employee.search(params[:search])
                                .paginate(:page => params[:page], :per_page => 10)
  end

private

  def employee_params
    params.require(:employee).permit(:name, :email)
  end

end
