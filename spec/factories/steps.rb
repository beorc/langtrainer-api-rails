class Cranky::Factory
  def step_stub
    stub_model(
      Step,
      id: options[:id] || n,
      en_answers: "step #{n}",
      ru_answers: "шаг #{n}",
      ru_question: options[:ru_question],
      ru_help: options[:ru_help],
      en_question: options[:en_question],
      en_help: options[:en_help]
    )
  end
end
