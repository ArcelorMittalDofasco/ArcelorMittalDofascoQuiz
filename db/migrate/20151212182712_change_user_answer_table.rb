class ChangeUserAnswerTable < ActiveRecord::Migration
  def change
    add_column :user_answers, :user_id, :integer, references: :users
  end
end
