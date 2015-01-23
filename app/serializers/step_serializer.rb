class StepSerializer < ActiveModel::Serializer
  attributes(
    :en_answers,
    :ru_answers,
    :ru_question,
    :ru_help,
    :en_question,
    :en_help
  )
end
