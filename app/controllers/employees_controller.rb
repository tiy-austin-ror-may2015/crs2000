class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])
  end

  # def invite
  #   @employee = current_employee
  #   em = Invitation.new(meeting_id: params[:id], employee_id: @employee.id)
  #   if em.save
  #   message = {notice: 'invitation successfully sent!'}
  #   else
  #     message = {alert: 'invitation sent failed!'}
  #   end
  #   redirect_to meeting_path(params[:id]), message
  # end

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
