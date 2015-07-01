class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])
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


private

  def employee_params
    params.require(:employee).permit(:name, :email)
  end

end
