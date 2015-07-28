# Returns Top Rated Review based on Atlas

module Parser
  class TopReview < Base

    def parse
      begin
        reviews = Parser::AllReviews.new(guide: @guide).parse
        reviews.sort! { |x, y| x['score'] <=> y['score'] }.last
      rescue StandardError => e
        raise ParseError, e.message
      end
    end

  end
end
