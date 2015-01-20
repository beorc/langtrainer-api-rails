Rails.application.routes.draw do
  put 'verify_answer' => 'unit/advances#verify_answer'
  put 'next_step' => 'unit/advances#next_step'
  put 'help_next_word' => 'unit/advances#help_next_word'
  put 'show_right_answer' => 'unit/advances#show_right_answer'
end
