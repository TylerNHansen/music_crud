# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  track_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Note < ActiveRecord::Base
  validates :body, :user_id, :track_id, presence: true
  belongs_to :user
  belongs_to :track
end
