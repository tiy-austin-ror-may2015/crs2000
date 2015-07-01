# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  agenda      :text             not null
#  start_time  :datetime         not null
#  end_time    :datetime         not null
#  private     :boolean          default(FALSE)
#  room_id     :integer
#  employee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
