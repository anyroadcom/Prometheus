class ErrorsController < ApplicationController
  def not_found
    render json: { message: 'Not found' }, status: :not_found
  end
end
