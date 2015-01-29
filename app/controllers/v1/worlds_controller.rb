class V1::WorldsController < V1::BaseController
  def world
    world = Jbuilder.new do |json|
      json.token current_user.token
      json.languages Language.published, :slug
      json.courses Course.published do |course|
        json.slug course.slug
        json.units course.units do |unit|
          json.slug unit.slug
          json.current_step current_user.current_step_for(unit)
        end
      end
    end

    render json: world.target!
  end

  def current_user
    @user ||= User.fetch_or_create_by!(params[:token])
  end
end
