class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
  @employee = Employee.find(params[:id])
  respond_to do |format|
    if @employee.update(employee_params)
      format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
      format.json { render :show, status: :ok, location: @employee }
    else
      format.html { render :edit }
      format.json { render json: @employee.errors, status: :unprocessable_entity }
    end
  end
end

private

  def employee_params
    params.require(:employee).permit(:name, :email)
  end

end
