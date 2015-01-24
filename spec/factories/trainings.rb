class Cranky::Factory
  def training_stub
    stub_model(
      Training,
      id: options[:id] || 1,
      language_id: Language.english.id,
      native_language_id: Language.russian.id
    ).tap do |m|
      m.user = Factory.build(:user_stub)
      m.unit = Factory.build(:unit_stub)
    end
  end
end
