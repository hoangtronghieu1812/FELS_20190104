class User < ApplicationRecord
  include PublicActivity::Model
  mount_uploader :image, PictureUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
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
    .includes(:owner, :recipient).where(recipient_id: user_id)
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

  def number_of_activities
    User.get_activities_of(self.id).count
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.image = auth.info.image
        user.role = Settings.user.member_role
      end
    end
  end
end
