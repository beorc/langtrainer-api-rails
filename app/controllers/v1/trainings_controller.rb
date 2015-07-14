class V1::TrainingsController < V1::BaseController
  before_action :fetch_training
  around_action :wrap_in_transaction

  def verify_answer
    Services::Training.new(self, @training).verify(params[:answer])
  end

  def next_step
    Services::Training.new(self, @training).next_step
  end

  def help_next_word
    Services::Training.new(self, @training).help_next_word
  end

  def show_right_answer
    Services::Training.new(self, @training).show_right_answer
  end

  def render_step(step)
    respond_with step
  end

  def render_nothing
    respond_with nil
  end

  def render_false
    respond_with false
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
    @training.difficulty_index = params[:difficulty_index].to_f
    @training.save!

    @training
  end

  def current_user
    @user ||= User.fetch_or_create_by!(params[:token])
  end

  def wrap_in_transaction
    ActiveRecord::Base.transaction { yield }
  end
end
