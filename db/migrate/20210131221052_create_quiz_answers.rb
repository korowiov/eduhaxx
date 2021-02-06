class CreateQuizAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_answers do |t|
      t.references :quiz_session, type: :uuid
      t.references :quiz_question, type: :uuid
      t.references :question_option, type: :uuid
      t.timestamps
    end
  end
end
