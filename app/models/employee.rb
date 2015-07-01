class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company
  has_many :meetings
  has_many :employee_meetings

  def self.search(search)
    self.where("lower(name) LIKE ? OR lower(email) LIKE ?",
               "%#{search}%", "%#{search}%")
  end

end
