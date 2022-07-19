class Group < ApplicationRecord

    has_many :messages, through: :user
    has_many :messages, through: :socialauth

end
