class Attendee < ApplicationRecord
  belongs_to :user
  belongs_to :study_group
end
