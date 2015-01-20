class TrainingService < Struct.new(:controller, :unit_advance)
  def right_answer!
    unit_advance.right_answer!
    unit_advance.step_passed!
  end

  def wrong_answer!
    unit_advance.wrong_answer!
  end

  def next_step
    unit_advance.step_passed!
    unit_advance.advance!

    next_step = unit_advance.fetch_step
    if next_step.present?
      controller.render_step(next_step)
    else
      unit_advance.revised!
      controller.render_step(unit_advance.fetch_step)
    end
  end

  def help_next_word
    unit_advance.word_helped!
    controller.render_nothing
  end

  def show_right_answer
    unit_advance.step_helped!
    unit_advance.step_passed!
    controller.render_nothing
  end

  def verify(answer)
    matched = false

    current_step = unit_advance.fetch_current_step
    Rails.logger.info "============================================ #{current_step.inspect} \n--- #{answer.inspect}"
    regexp = current_step.regexp(unit_advance.language.slug)

    if regexp.present?
      matched = /#{regexp}/.match(answer)
    else
      right_answer = Regexp.escape current_step.send(unit_advance.language.slug)
      matched = /#{right_answer}/.match(answer)
    end

    if matched
      controller.right_answer
    else
      controller.wrong_answer
    end
  end
end
