class InvitationsController < ActionController::Base

  def invite
      if Invitation.where(meeting_id: params[:meeting_id], employee_id: params[:employee_id]).count == 0
        invitation = Invitation.new(meeting_id: params[:meeting_id], employee_id: params[:employee_id])
        invitation.save
        @employee = Employee.find(params[:employee_id])
        @meeting = Meeting.find(params[:meeting_id])
        MeetingMailer.invited_to_meeting(@employee, @meeting).deliver_now
          message = {notice: 'invitation successfully sent!'}
        else
          message = {alert: 'invitation has been already sent!'}
        end
      redirect_to meeting_path(params[:meeting_id]), message
  end

end
