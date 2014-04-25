# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  kind       :string(255)
#  name       :string(255)
#  band_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  validates :kind, :name, :band_id, presence: true

  belongs_to :band
  has_many :tracks

  def band_name
    band.name
  end
end
