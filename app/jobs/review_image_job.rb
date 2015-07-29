class ReviewImageJob < ActiveJob::Base
  queue_as :default

  def perform(review)
    image_url = Parser::CreateImage.new(review).parse

    # Update Review
  end
end
