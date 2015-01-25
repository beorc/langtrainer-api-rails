class Cranky::Factory
  def course_stub
    stub_model(
      Course,
      id: options[:id] || n,
      slug: options[:slug] || options[:id] || n,
      published: options[:published] || true
    )
  end
end
