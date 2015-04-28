RSpec::Matchers.define :have_delete_link do |*expected|
  match do |actual|
    if actual.has_link?(*expected)
      link = find_link(*expected)
      link['data-method'] == 'delete'
    end
  end

  failure_message do |actual|
    "expected that page has flash message in\n#{actual.body}"
  end

  failure_message_when_negated do |actual|
    "expected that page does not have flash message in\n#{actual.body}"
  end
end