# == Schema Information
#
# Table name: employees
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  name                   :string
#  admin                  :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :integer
#

class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company
  has_many :meetings
  has_many :employee_meetings
  has_many :invitations
  has_many :viewable_meetings, through: :invitations, source: :meeting
  has_many :confirmed_meetings, through: :employee_meetings, source: :meeting
  scope :next_meeting, -> { confirmed_meetings.order(:star_time) }

  def self.search(search)
    self.where("lower(name) LIKE ? OR lower(email) LIKE ?",
               "%#{search}%", "%#{search}%")
  end
  def self.next_mtn
    self.confirmed_meetings.order(:star_time).limit(1)
  end
end
