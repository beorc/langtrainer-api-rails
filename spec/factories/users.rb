class Cranky::Factory
  def user_stub
    stub_model(
      User,
      id: options[:id] || 1,
      token: '123456-test'
    )
  end
end
