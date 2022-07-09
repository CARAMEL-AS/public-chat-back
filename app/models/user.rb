class User < ActiveRecord::Base

    has_many :groups
    has_many :messages, through: :groups
    has_one :warning

    validates :password_digest, presence: true 
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    has_secure_password
end