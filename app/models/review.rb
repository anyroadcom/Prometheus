class Review < ActiveRecord::Base
  belongs_to :guide

  validates :score, presence: true
  validates :body, presence: true
  # validates :image_url, uniqueness: true
end
