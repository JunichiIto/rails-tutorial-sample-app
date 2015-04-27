module RelationshipMacros
  def create_relationships(
      michael: FactoryGirl.create(:michael),
      archer: FactoryGirl.create(:archer),
      lana: FactoryGirl.create(:lana),
      mallory: FactoryGirl.create(:mallory))
    FactoryGirl.create :relationship, follower: michael, followed: lana
    FactoryGirl.create :relationship, follower: michael, followed: mallory
    FactoryGirl.create :relationship, follower: lana, followed: michael
    FactoryGirl.create :relationship, follower: archer, followed: michael
  end
end