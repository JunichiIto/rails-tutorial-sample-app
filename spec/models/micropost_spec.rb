require 'rails_helper'

describe Micropost do
  let!(:user) { create :michael_with_microposts }
  let(:micropost) { user.microposts.build(content: 'Lorem ipsum') }

  it 'should be valid' do
    expect(micropost).to be_valid
  end

  specify 'user id should be present' do
    micropost.user_id = nil
    expect(micropost).to be_invalid
  end

  specify 'content should be present' do
    micropost.content = ' '
    expect(micropost).to be_invalid
  end

  specify 'content should be at most 140 characters' do
    micropost.content = 'a' * 141
    expect(micropost).to be_invalid

    micropost.content = 'a' * 140
    expect(micropost).to be_valid
  end

  specify 'order should be most recent first' do
    content = attributes_for(:most_recent)[:content]
    most_recent = Micropost.find_by content: content
    expect(Micropost.count).to be > 1, 'Confirm test data exists'
    expect(Micropost.first).to eq most_recent
  end

  specify 'picture size should be at most 5MB' do
    # Use mock to control file size
    picture = File.new('spec/fixtures/rails.png')
    allow(picture).to receive(:size).and_return(5.1.megabytes)
    allow(micropost).to receive(:picture).and_return(picture)
    expect(micropost).to be_invalid

    allow(picture).to receive(:size).and_return(5.0.megabytes)
    expect(micropost).to be_valid
  end
end

# require 'test_helper'
#
# class MicropostTest < ActiveSupport::TestCase
#   def setup
#     @user = users(:michael)
#     @micropost = @user.microposts.build(content: 'Lorem ipsum')
#   end
#
#   test 'should be valid' do
#     assert @micropost.valid?
#   end
#
#   test 'user id should be present' do
#     @micropost.user_id = nil
#     assert_not @micropost.valid?
#   end
#
#   test 'content should be present' do
#     @micropost.content = ' '
#     assert_not @micropost.valid?
#   end
#
#   test 'content should be at most 140 characters' do
#     @micropost.content = 'a' * 141
#     assert_not @micropost.valid?
#   end
#
#   test 'order should be most recent first' do
#     assert_equal Micropost.first, microposts(:most_recent)
#   end
# end
