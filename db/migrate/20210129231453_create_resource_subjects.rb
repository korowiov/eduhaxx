class CreateResourceSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_subjects do |t|
      t.references :subject
      t.references :subjectable, polymorphic: true, type: :uuid
      t.timestamps
    end
  end
end
