class Cranky::Factory
  def unit_stub
    stub_model(
      Unit,
      id: options[:id] || 1,
      slug: 'first'
    ).tap do |m|
      m.course = Factory.build(:course_stub)
    end
  end
end
