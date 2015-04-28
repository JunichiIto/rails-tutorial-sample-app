require 'rails_helper'

describe Relationship do
  let(:relationship) { Relationship.new(follower_id: 1, followed_id: 2) }

  it 'should be valid' do
    expect(relationship).to be_valid
  end

  it 'should require a follower_id' do
    relationship.follower_id = nil
    expect(relationship).to be_invalid
  end

  it 'should require a followed_id' do
    relationship.followed_id = nil
    expect(relationship).to be_invalid
  end
end

# require 'test_helper'
#
# class RelationshipTest < ActiveSupport::TestCase
#   def setup
#     @relationship = Relationship.new(follower_id: 1, followed_id: 2)
#   end
#
#   test 'should be valid' do
#     assert @relationship.valid?
#   end
#
#   test 'should require a follower_id' do
#     @relationship.follower_id = nil
#     assert_not @relationship.valid?
#   end
#
#   test 'should require a followed_id' do
#     @relationship.followed_id = nil
#     assert_not @relationship.valid?
#   end
# end
