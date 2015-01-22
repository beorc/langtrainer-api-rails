source 'https://rubygems.org'


gem 'rails', '4.2.0'

gem 'rails-api'


gem 'pg'
gem 'versionist'
gem 'langtrainer_orm_activerecord', git: 'git@github.com:beorc/langtrainer_orm_activerecord.git', branch: 'master'
gem 'rollbar', '~> 1.3.1'
gem 'active_model_serializers'

group :production do
  gem 'puma'
end

group :development do
  gem 'figaro'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'rspec-activemodel-mocks'
  gem 'approvals', '~> 0.0.16'
  gem 'cranky'
end
