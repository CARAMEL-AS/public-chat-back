class User < ActiveRecord::Base

    validates :password_digest, presence: true 
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    has_secure_password
end