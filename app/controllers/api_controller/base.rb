require_dependency 'api_controller/exceptions'

module ApiController
  class Base < ActionController::Base
    include ApiController::Rescue

    before_filter :ensure_json

    protected

    def authenticate!
      # raise ApiController::Forbidden unless param['api_key'] == '123'
    end

    private

    def ensure_json
      raise ApiController::UnsupportedMediaType unless ensure_json_format || ensure_json_content_type
    end

    def ensure_json_format
      params[:format].to_s == 'json'
    end

    def ensure_json_content_type
      request.headers['Content-Type'] =~ /application\/json/
    end
  end
end
