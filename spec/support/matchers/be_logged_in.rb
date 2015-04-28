RSpec::Matchers.define :be_logged_in do |*expected|
  match do |actual|
    if actual.is_a?(Capybara::Session)
      actual.find('header').has_link? 'Account'
    else
      actual[:user_id]
    end
  end

  failure_message do |actual|
    "expected to be logged in"
  end

  failure_message_when_negated do |actual|
    "expected to not be logged in"
  end
end
