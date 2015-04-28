module RelationshipMacros
  def create_relationships(
      michael: create(:michael),
      archer: create(:archer),
      lana: create(:lana),
      mallory: create(:mallory))
    [
      create(:relationship, follower: michael, followed: lana),
      create(:relationship, follower: michael, followed: mallory),
      create(:relationship, follower: lana, followed: michael),
      create(:relationship, follower: archer, followed: michael)
    ]
  end
end