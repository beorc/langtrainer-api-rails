class V1::TrainingsController < V1::BaseController
  before_action :fetch_training

  def verify_answer
    ActiveRecord::Base.transaction do
      Services::Training.new(self, @training).verify(params[:answer])
    end
  end

  def next_step
    ActiveRecord::Base.transaction do
      Services::Training.new(self, @training).next_step
    end
  end

  def help_next_word
    ActiveRecord::Base.transaction do
      Services::Training.new(self, @training).help_next_word
    end
  end

  def show_right_answer
    ActiveRecord::Base.transaction do
      Services::Training.new(self, @training).show_right_answer
    end
  end

  def render_step(step)
    render json: step
  end

  def render_nothing
    render json: nil
  end

  def render_false
    render json: false
  end

  private

  def fetch_training
    user = current_user
    unit = Unit.find(params[:unit])
    step = Step.find(params[:step])
    language = Language.find(params[:language])
    native_language = Language.find(params[:native_language])

    @training = Training.find_or_create_by({
      user_id: user.id,
      unit_id: unit.id,
      language_id: language.id,
      native_language_id: native_language.id
    })

    @training.current_step = step
    @training.save!

    @training
  end

  def current_user
    @user ||= User.find_by(token: params[:token])
  end
end
