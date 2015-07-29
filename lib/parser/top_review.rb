# Returns Top Rated Review based on Atlas

module Parser
  class TopReview < Base

    def parse
      begin
        reviews = Parser::AllReviews.new(guide: @guide).parse
        top_review = reviews.sort! { |x, y| x['score'] <=> y['score'] }.last

        # XXX Check if reviews exists already
        review = @guide.reviews.create!(top_review.to_h)

        # Draw Image
        ReviewImageJob.perform_later(review)

      rescue StandardError => e
        raise ParseError, e.message
      end
    end

  end
end
