RSpec::Matchers.define :have_flash_message do |*expected|
  match do |actual|
    actual.has_selector? '.alert'
  end

  failure_message do |actual|
    "expected that page has flash message in\n#{actual.body}"
  end

  failure_message_when_negated do |actual|
    "expected that page does not have flash message in\n#{actual.body}"
  end
end