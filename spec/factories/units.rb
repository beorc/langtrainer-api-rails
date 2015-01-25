class Cranky::Factory
  def unit_stub
    stub_model(
      Unit,
      id: options[:id] || n,
      slug: options[:slug] || options[:id] || n,
      published: options[:published] || true
    )
  end

  def unit_with_course_stub
    stub_model(
      Unit,
      id: options[:id] || n,
      slug: options[:slug] || options[:id] || n,
      published: options[:published] || true
    ).tap do |m|
      m.course = Factory.build(:course_stub)
    end
  end
end
