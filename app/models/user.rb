# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # test
  # User sign up method
  def self.sign_up(params)
    user = User.new(params)
    if user.save
      # Additional logic after successful sign up
    else
      # Handle sign up errors
    end
    user
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # Set additional attributes from auth hash if needed
    end
  end

  def self.new_with_session(params, session)
    user = User.new(params)
    if session["devise.user_attributes"]
      user.attributes = session["devise.user_attributes"]
      user.valid?
    end
    user
  end

  def self.find_for_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first
  end

  
end
