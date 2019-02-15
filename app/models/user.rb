class User < ApplicationRecord
  mount_uploader :image, PictureUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships,
    source: :followed
  has_many :followers, through: :passive_relationships,
    source: :follower

  scope :get_activities_of, ->user_id { PublicActivity::Activity
    .includes(:owner, :recipient).where(owner_id: user_id)
      .order created_at: :desc }

  enum role: [:member, :admin]

  def follow user
    following << user
  end

  def unfollow user
    following.delete user
  end

  def followed? user
    Relationship.exists? follower_id: self.id, followed_id: user.id
  end
end
