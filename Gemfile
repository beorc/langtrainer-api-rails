ruby '2.2.1'
source 'https://rubygems.org'


gem 'rails', '4.2.0'

gem 'rails-api'


gem 'pg'
gem 'versionist'
gem 'langtrainer_orm_activerecord', github: 'langtrainer/langtrainer_orm_activerecord', branch: 'master'
gem 'rollbar', '~> 1.3.1'
gem 'jbuilder'

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'newrelic_rpm'
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
  gem 'cranky'
  gem 'approvals', '~> 0.0.17'
end
