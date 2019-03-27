class Relationship < ApplicationRecord
  include PublicActivity::Common
  validate :cannot_follow_yourself
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  validates :follower_id, uniqueness: { scope: :followed_id }

  private
    def cannot_follow_yourself
      if followed_id == follower_id
        errors.add(:you, Settings.relationship.cannot_follow_yourself )
      end
    end
end
