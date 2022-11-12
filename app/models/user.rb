class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  has_many :comments
  has_many :likes
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name:  :Friendship, foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :messages

  has_many :chatrooms, foreign_key: :chat_sender_id
  has_many :chat_receivers, through: :chatrooms
  has_many :inverse_chatrooms, class_name: :Chatroom, foreign_key: :chat_receiver_id
  has_many :chat_senders, through: :inverse_chatrooms

  has_many :friend_requests, foreign_key: :receiver
  has_many :requestors, through: :friend_requests

  has_many :inverse_friend_requests, class_name: :FriendRequest, foreign_key: :requestor 
  has_many :receivers, through: :inverse_friend_requests

  before_save {self.email = email.downcase()}
  has_many :articles, dependent: :destroy
  validates :username, presence: true, uniqueness: {case_sensitive: false} , length: {minimum: 3, maximum: 25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 105}, format: {with: VALID_EMAIL_REGEX}

  mount_uploader :avatar, AvatarUploader
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def getFriends()
    return self.friends + self.inverse_friends
  end

  def getChatFriends()
    return self.chat_senders + self.chat_receivers
  end
end
