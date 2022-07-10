class User < ActiveRecord::Base

    has_many :messages
    has_many :appwarnings

    validates :password_digest, presence: true 
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    has_secure_password
end