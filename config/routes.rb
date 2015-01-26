Rails.application.routes.draw do
  api_version(:module => "V1", :path => {:value => "v1"}, :defaults => {:format => "json"}, :default => true) do
    get 'world' => 'worlds#world'

    get 'verify_answer' => 'trainings#verify_answer'
    get 'next_step' => 'trainings#next_step'
    get 'help_next_word' => 'trainings#help_next_word'
    get 'show_right_answer' => 'trainings#show_right_answer'
  end
end
