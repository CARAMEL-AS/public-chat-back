class User < ActiveRecord::Base

    has_many :messages
    has_many :appwarnings
    has_one :accverify
    has_one :setting

    validates :password_digest, presence: true 
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

    has_secure_password
end