class TrainingsController < ApplicationController
  respond_to :json
  before_filter :fetch_training

  def verify_answer
    TrainingService.new(self, @training).verify(params[:answer])
  end

  def next_step
    TrainingService.new(self, @training).next_step
  end

  def help_next_word
    TrainingService.new(self, @training).help_next_word
  end

  def show_right_answer
    TrainingService.new(self, @training).show_right_answer
  end

  def right_answer
    @training.put_current_step_to_next_box!
    @training.step_revised!
    TrainingService.new(self, @training).right_answer!
    render json: { correct: true, comment: t('units.show.comments.correct') }
  end

  def wrong_answer
    @training.put_current_step_to_first_box!
    TrainingService.new(self, @training).wrong_answer!
    render json: { correct: false, comment: t('units.show.comments.wrong') }
  end

  def render_step(step)
    markup = view_context.render partial: 'units/step', object: step
    render json: { markup: markup }
  end

  def render_nothing
    render nothing: true
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

    raise 'Training not found!' if @training.nil?
  end
end
