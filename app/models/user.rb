class User < ActiveRecord::Base
  has_many :user_answers
  has_many :answers, :through => :user_answers
  validates :name, presence: true, :uniqueness => true
  validates :email, presence: true, :uniqueness => true
end
