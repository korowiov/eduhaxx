class CreateQuizSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_sessions, id: :uuid do |t|
      t.references :quiz, type: :uuid
      t.integer :score
      t.datetime :finished_at
      t.jsonb :configuration, default: {}
      t.timestamps
    end
  end
end
