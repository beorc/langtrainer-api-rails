class V1::WorldsController < V1::BaseController
  def world
    world = Jbuilder.new do |json|
      json.token current_user.token
      json.languages Language.published, :slug
      json.courses Course.published do |course|
        json.slug course.slug
        json.units course.units do |unit|
          json.id unit.id
          json.course_slug course.slug
          json.slug unit.slug
          json.current_step do
            json.unit_id unit.id
            json.merge! current_user.current_step_for(unit).attributes
          end
        end
      end
    end

    render json: world.target!
  end

  def current_user
    @user ||= User.fetch(params[:token])
  end
end
