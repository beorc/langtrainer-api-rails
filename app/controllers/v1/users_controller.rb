class V1::UsersController < V1::BaseController
  def token
    user = User.create!
    render json: user.token
  end
end
