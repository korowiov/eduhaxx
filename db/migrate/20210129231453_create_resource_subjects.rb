class CreateResourceSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_subjects do |t|
      t.references :resource, type: :uuid
      t.references :subject
      t.timestamps
    end
  end
end
