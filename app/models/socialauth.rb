class Socialauth < ApplicationRecord

    has_many :messages
    has_many :appwarnings
    has_one :accverify

    
end
