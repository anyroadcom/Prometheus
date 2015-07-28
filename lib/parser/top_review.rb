# Returns Top Rated Review based on Atlas

module Parser
  class TopReview < Base

    def parse
      begin
        reviews = Parser::AllReviews.new(guide: @guide).parse
        top_review = reviews.sort! { |x, y| x['score'] <=> y['score'] }.last

        # XXX Check if reviews exists already
        @guide.reviews.create!(top_review.to_h)

      rescue StandardError => e
        raise ParseError, e.message
      end
    end

  end
end
