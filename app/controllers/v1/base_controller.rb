class V1::BaseController < ApplicationController
  serialization_scope :self

  def current_user
    user = session[:current_user]

    if user.nil?
      user = User.fetch_or_create_by!(params[:token])
      session[:current_user] = user
    end

    user
  end
end
