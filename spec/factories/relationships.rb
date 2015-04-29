FactoryGirl.define do
  factory :relationship do
    follower nil
    followed nil
  end
end

# NOTE Following data is created in support/relationship_macros
# one:
#   follower: michael
#   followed: lana
#
# two:
#   follower: michael
#   followed: mallory
#
# three:
#   follower: lana
#   followed: michael
#
# four:
#   follower: archer
#   followed: michael
