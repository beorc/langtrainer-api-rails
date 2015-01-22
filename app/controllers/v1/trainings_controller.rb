class V1::TrainingsController < V1::BaseController
  respond_to :json
  before_action :fetch_training

  def verify_answer
    ActiveRecord::Base.transaction do
      TrainingService.new(self, @training).verify(params[:answer])
    end
  end

  def next_step
    ActiveRecord::Base.transaction do
      TrainingService.new(self, @training).next_step
    end
  end

  def help_next_word
    ActiveRecord::Base.transaction do
      TrainingService.new(self, @training).help_next_word
    end
  end

  def show_right_answer
    ActiveRecord::Base.transaction do
      TrainingService.new(self, @training).show_right_answer
    end
  end

  def right_answer
    ActiveRecord::Base.transaction do
      @training.push_current_step_to_next_box!
      @training.step_revised!
      TrainingService.new(self, @training).right_answer!
    end

    render json: true
  end

  def wrong_answer
    ActiveRecord::Base.transaction do
      @training.push_current_step_to_first_box!
      TrainingService.new(self, @training).wrong_answer!
    end

    render json: false
  end

  def render_step(step)
    render json: step
  end

  def render_nothing
    render json: nil
  end

  private

  def fetch_unit_advance
    user = User.find_by(params[:token])
    unit = Unit.find(params[:unit])
    language = Language.find(params[:language])
    native_language = Language.find(params[:native_language])

    @training = Training.find_by {
      user_id: user.id,
      unit_id: unit.id,
      language_id: language.id,
      native_language_id: native_language.id
    }

    fail 'Training not found!' if @training.nil?
  end
end
