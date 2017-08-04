class Book < ApplicationRecord

  has_many :reviews
  has_and_belongs_to_many :authors
  has_many :users, through: :reviews

end
