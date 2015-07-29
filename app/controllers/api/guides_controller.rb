module Api
  class GuidesController < BaseController

    def index
      @guides = Guide.all
      render json: @guides
    end

    def get_image
      begin
        @guide = Guide.where(anyguide_id: params[:anyguide_id]).first_or_initialize(trip_url: params[:trip_url])
        @guide.save! if @guide.new_record?

        # Parse Top Review
        top_review = Parser::TopReview.new(guide: @guide).parse

        render json: { guide: @guide, review: top_review }, status: :ok
      rescue StandardError, ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
        render json: { errors: e.message }, status: 400
      end
    end

  end
end
