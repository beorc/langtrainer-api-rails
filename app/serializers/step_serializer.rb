class StepSerializer < ActiveModel::Serializer
  attributes :en, :ru, :ru_template, :ru_help, :en_template, :en_help
end
