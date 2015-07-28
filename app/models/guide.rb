class Guide < ActiveRecord::Base
  validates :anyguide_id, presence: true, uniqueness: true
  validates :trip_url, presence: true, uniqueness: true

  has_many :reviews

  ## Parse Reviews
end
