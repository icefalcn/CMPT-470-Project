class Contact < ActiveRecord::Base
  validates :First_Name, presence: true
  validates :Last_Name, presence: true
end
