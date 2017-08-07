class User < ApplicationRecord
  validates :agreement, acceptance: { on: :create }
  validates :email, presence: { unless: 'dm.blank?' }, confirmation: true
  has_one :author
end
