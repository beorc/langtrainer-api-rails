class V1::BaseController < ApplicationController
  after_action :set_access_control_headers

  def handle_options_request
    head(:no_content) if request.request_method == 'OPTIONS'
  end

  private

  # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS?redirectlocale=en-US&redirectslug=HTTP_access_control
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, X-CSRF-Token'
    headers['Access-Control-Max-Age'] = '1728000'
    headers['X-Frame-Options'] = 'GOFORIT'
  end
end
