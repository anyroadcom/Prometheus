class ReviewImageJob < ActiveJob::Base
  queue_as :default

  def perform(review)
    image_url = Parser::CreateImage.new(review).parse

    # Update Review
    review.update_attributes(image_url: image_url)

    # Send to Endpoint
    # senderino de la anyguiderino
  end
end
