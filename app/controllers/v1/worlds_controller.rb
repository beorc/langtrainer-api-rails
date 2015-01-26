class V1::WorldsController < V1::BaseController
  def world
    world = {
      token: current_user.token,
      languages: Language.published,
      courses: Course.published
    }

    render json: world
  end
end
