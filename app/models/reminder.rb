class Reminder < ApplicationRecord
  validates_presence_of :title, :created_by
end
