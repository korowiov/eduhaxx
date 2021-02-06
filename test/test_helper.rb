require 'webmock/minitest'
require 'minitest/autorun'
require 'mocha/minitest'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
Dir['./test/support/**/*.rb'].each { |f| require f }

Minitest.backtrace_filter = Minitest::BacktraceFilter.new

class ActiveSupport::TestCase
  extend MiniTest::Spec::DSL
  include FactoryBot::Syntax::Methods

  # parallelize(workers: :number_of_processors)

  def json_response
    ActiveSupport::JSON.decode @response.body
  end
end
