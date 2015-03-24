RSpec.configure do |config|  
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  config.backtrace_exclusion_patterns << /gems/
  # config.include HelperMethods
end