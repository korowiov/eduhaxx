class AddReferencQuizSessionToAccount < ActiveRecord::Migration[6.1]
  def change
    add_reference :quiz_sessions, :account, type: :uuid, index: true
  end
end
