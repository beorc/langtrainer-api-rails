class V1::BaseController < ApplicationController
  include ActionController::ImplicitRender
  respond_to :json
end
