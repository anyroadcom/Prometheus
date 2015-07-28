module Api
  class ReviewsController < BaseController

    def index
      @reviews = Review.all
      render json: @review
    end

  end
end
