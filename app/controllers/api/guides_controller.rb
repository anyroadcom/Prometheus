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
        # ReviewImageJob.perform_later @guide
        render json: @guide, status: :ok
      rescue StandardError, ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
        render json: { errors: e.message }, status: 400
      end
    end

  end
end
