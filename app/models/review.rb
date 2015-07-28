class Review < ActiveRecord::Base
  belongs_to :guide
  validates_presence_of :score, :image_url
end
