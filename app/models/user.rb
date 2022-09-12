class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts
  has_many :comments
  has_many :likes

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     user.user_name = auth.info.name   # assuming the user model has a name
    end
  end

  def role?
    if self.has_role? :admin
      return "Admin"
    else
      return "User"
    end
  end
end
