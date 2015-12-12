class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :users, :through => :user_answers
end
