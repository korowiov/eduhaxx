class CreateQuestionOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :question_options, id: :uuid do |t|
      t.references :quiz_question, type: :uuid
      t.string :content
      t.boolean :value
      t.timestamps
    end
  end
end
