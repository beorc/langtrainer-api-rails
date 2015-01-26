class V1::CoursesController < V1::BaseController
  def index
    render json: Course.published
  end
end
