class Services::Training < Struct.new(:controller, :training)
  DIFFICULTY_INDEX_THRESHOLD = 0.1

  def right_answer!
    if training.difficulty_index < DIFFICULTY_INDEX_THRESHOLD
      training.push_current_step_to_next_box!
    end

    training.step_revised!
    training.right_answer!

    next_step
  end

  def wrong_answer!
    training.push_current_step_to_first_box!
    training.wrong_answer!

    controller.render_false
  end

  def verify(answer)
    if training.right_answer?(answer)
      right_answer!
    else
      wrong_answer!
    end
  end

  def next_step
    training.step_passed!

    controller.render_step(training.fetch_step!)
  end

  def help_next_word
    training.word_helped!

    controller.render_nothing
  end

  def show_right_answer
    training.step_helped!
    training.step_passed!

    controller.render_nothing
  end
end
