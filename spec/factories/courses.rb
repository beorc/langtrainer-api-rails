class Cranky::Factory
  def course_stub
    stub_model(
      Course,
      id: options[:id] || 1
    )
  end
end
