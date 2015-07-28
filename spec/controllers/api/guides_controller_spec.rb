require 'rails_helper'
require File.expand_path('spec/shared/api_base_controller')

RSpec.describe Api::GuidesController, type: :controller do
  it_behaves_like 'api base controller'
end
