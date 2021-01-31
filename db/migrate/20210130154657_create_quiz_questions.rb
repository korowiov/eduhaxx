class CreateQuizQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_questions, id: :uuid do |t|
      t.references :quiz, type: :uuid
      t.string :content
      t.string :question_type, null: false, index: true
      t.timestamps
    end
  end
end
