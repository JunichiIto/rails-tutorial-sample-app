FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email { Faker::Internet.email }
    password 'password'
    password_confirmation { password }
    activated true
    activated_at Time.zone.now

    factory :michael do
      name 'Michael Example'
      email 'michael@example.com'
      admin true
    end

    factory :archer do
      name 'Sterling Archer'
      email 'duchess@example.gov'
      after :create do |user|
        create :ants, user: user
        create :zone, user: user
      end
    end

    factory :lana do
      name 'Lana Kane'
      email 'hands@example.gov'
    end

    factory :mallory do
      name 'Mallory Archer'
      email 'boss@example.gov'
    end
  end
end

# michael:
#   name: Michael Example
#   email: michael@example.com
#   password_digest: <%= User.digest('password') %>
#   admin: true
#   activated: true
#   activated_at: <%= Time.zone.now %>
#
# archer:
#   name: Sterling Archer
#   email: duchess@example.gov
#   password_digest: <%= User.digest('password') %>
# activated: true
# activated_at: <%= Time.zone.now %>
#
# lana:
#   name: Lana Kane
#   email: hands@example.gov
#   password_digest: <%= User.digest('password') %>
#     activated: true
# activated_at: <%= Time.zone.now %>
#
# mallory:
#   name: Mallory Archer
#   email: boss@example.gov
#   password_digest: <%= User.digest('password') %>
#     activated: true
# activated_at: <%= Time.zone.now %>
#
# <% 30.times do |n| %>
# user_<%= n %>:
#     name:  <%= "User #{n}" %>
#   email: <%= "user-#{n}@example.com" %>
#     password_digest: <%= User.digest('password') %>
#   activated: true
#   activated_at: <%= Time.zone.now %>
# <% end %>
