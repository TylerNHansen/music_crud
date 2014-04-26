# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  lyrics     :text
#  kind       :string(255)
#  album_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  title      :string(255)      not null
#

class Track < ActiveRecord::Base
  validates :lyrics, :kind, :album_id, :title, presence: true

  belongs_to :album
  has_one :band, through: :album
  has_many :notes
  has_many :tracks, through: :album
end
