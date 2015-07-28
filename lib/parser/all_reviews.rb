# coding: utf-8
# Parses given TripAdvisor URL and returns all 5★  reviews

module Parser
  class AllReviews < Base

    attr_reader :score, :body, :image_url
    Review = Struct.new(:score, :body, :image_url)

    # def post_initialize
      # Pass other params if needed
    # end

    def parse
      begin
        # Parse Top Review
        atlas = ['professional', 'amazing', 'friendly', 'great', 'interesting', 'breathtaking']
        five_star_reviews = []

        reviews.each do |review|
            if has_five_stars?(review)
            score = 0

            review_body = review.css('div.entry').css('p').text # for image -> .truncate_words(20)
            tagged = tagger.add_tags(review_body)
            adj = tagger.get_adjectives(tagged)

            if adj.any?
                adj.each do |a|
                score += 0.5 if atlas.include? a.first
                end
            end

            # Calculate Score
            atlas_score = (adj.count + score)

            r = Review.new(
              atlas_score,
              review_body
            )

            # Add to Array
            five_star_reviews << r
            end
        end
      rescue StandardError => e
        raise ParseError, e.message
      end

      five_star_reviews

    end

    protected

    def has_five_stars?(review)
      review.css('div.basic_review').css('div.col2of2').css('div.innerBubble').css('div.rating').css('img.s50').present?
    end
  end
end
