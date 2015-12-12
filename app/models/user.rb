class User < ActiveRecord::Base
  has_many :user_answers
  has_many :answers, :through => :user_answers
  validates :name, presence: true
  validates :email, presence: true
end
