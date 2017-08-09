class Book < ApplicationRecord
  after_destroy BookCallbacks.new

  validates :isbn,
    presence: { message: 'は必須です。' },
    uniqueness: { allow_blank: true, message: '%{value}は一意でなければなりません。' },
    length: { is: 17, allow_blank: true, message: 'は%{count}桁でなければなりません。' },
    isbn: { allow_old: true, allow_blank: true }
  validates :title,
    presence: { message: 'は必須です。' },
    length: { minimum: 1, maximum: 100, message: 'は1文字以上、100文字未満で入力してください。' }
  validates :price,
    numericality: { only_integer: true, less_than: 10000, message: 'に数字を入力してください。' }
  validates :publish,
    inclusion: { in: ['技術評論社','翔泳社','秀和システム','日経BP社','ソシム'], message: 'を選択してください。' }



  has_many :reviews
  has_and_belongs_to_many :authors
  has_many :users, through: :reviews
  has_many :memos, as: :memoable

  scope :gihyo, -> { where(publish: '技術評論社') }
  scope :newer, -> { order(published: :desc) }
  scope :top10, -> { newer.limit(10) }


end
