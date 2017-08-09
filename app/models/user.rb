class User < ApplicationRecord
  validates :agreement, acceptance: { on: :create }
  validates :email, presence: { unless: 'dm.blank?' }, confirmation: true
  has_one :author
  has_many :reviews
  has_many :books, through: :reviews
end
