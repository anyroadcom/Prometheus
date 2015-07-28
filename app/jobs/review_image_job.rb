class ReviewImageJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
