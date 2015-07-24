module ApiController
  module Rescue
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError do |exception|
        render json: { message: 'Something went wrong' }, status: :internal_error
      end

      rescue_from ApiController::Unauthorized do |exception|
        render json: { message: 'Unauthorized' }, status: :unauthorized
      end

      rescue_from ApiController::Forbidden do |exception|
        render json: { message: 'Forbidden' }, status: :forbidden
      end

      rescue_from ApiController::UnsupportedMediaType do |exception|
        render json: { message: 'Unsupported content type' }, status: :unsupported_media_type
      end
    end

  end
end
