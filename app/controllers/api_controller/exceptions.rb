module ApiController
  class UnsupportedMediaType < ActionController::ActionControllerError
  end

  class Unauthorized < ActionController::ActionControllerError
  end

  class Forbidden < ActionController::ActionControllerError
  end
end
