class InvitationsController < ApplicationController

  def create
    meeting_id  = params[:invitation][:meeting_id]
    employee_id = params[:invitation][:employee_id]
      if Invitation.where(meeting_id: meeting_id, employee_id: employee_id).count == 0
        invitation = Invitation.new(meeting_id: meeting_id , employee_id: employee_id)
        invitation.save
        @employee = Employee.find(employee_id)
        @meeting = Meeting.find(meeting_id)
        MeetingMailer.invited_to_meeting(@employee, @meeting).deliver_now
          message = {notice: 'invitation successfully sent!'}
        else
          message = {alert: 'invitation has been already sent!'}
        end
      redirect_to admin_invitations_show_path, message
  end

  def show
    @invitations = Invitation.all
    all_employees = Employee.where(company_id: current_company_id)
    @employee_options = all_employees.map { |employee| [employee.name, employee.id]}
    @current_company = current_company
    @meeting_options = @current_company.meetings.map { |meeting| [meeting.title, meeting.id] }
  end

  def new
    @new_invitation = Invitation.create
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    message = { alert: 'Meeting was successfully deleted'}
    redirect_to admin_invitations_show_path, message
  end

end
