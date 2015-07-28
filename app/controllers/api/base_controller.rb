module Api
  class BaseController < ActionController::Base

    before_filter :ensure_json

    protected

    def authenticate!
      # raise ApiController::Forbidden unless param['api_key'] == '123'
    end

    private

    def ensure_json
      raise Api::UnsupportedMediaType unless ensure_json_format || ensure_json_content_type
    end

    def ensure_json_format
      params[:format].to_s == 'json'
    end

    # def resource_klass
    #   resource_klass_name.constantize
    # end

    # def resource_klass_name
    #   self.class.name.demodulize.sub('Controller', '').singularize
    # end

    # def resource
    #   @resource ||= resource_klass.where(id: params[:id]).first!
    # end

    def ensure_json_content_type
      request.headers['Content-Type'] =~ /application\/json/
    end

    # Rescues
    rescue_from StandardError do |exception|
      render json: { message: 'Something went wrong' }, status: :internal_error
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render json: { message: "Guide not found" }, status: :not_found
    end

    rescue_from Api::Unauthorized do |exception|
      render json: { message: 'Unauthorized' }, status: :unauthorized
    end

    rescue_from Api::Forbidden do |exception|
      render json: { message: 'Forbidden' }, status: :forbidden
    end

    rescue_from Api::UnsupportedMediaType do |exception|
      render json: { message: 'Unsupported content type' }, status: :unsupported_media_type
    end
  end
end
