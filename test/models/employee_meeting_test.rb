# == Schema Information
#
# Table name: employee_meetings
#
#  id          :integer          not null, primary key
#  enrolled    :integer          default(0)
#  employee_id :integer
#  meeting_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class EmployeeMeetingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
