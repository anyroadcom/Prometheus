class Review < ActiveRecord::Base
  belongs_to :guide

  validates :score, presence: true
  validates :body, presence: true, uniqueness: true
  validates :image_url, uniqueness: true
end
