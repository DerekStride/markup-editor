class CreateWorkingDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :working_documents do |t|
      t.string :owner, null: false
      t.string :repo_name, null: false
      t.integer :issue_number, null: false

      t.string :issue_title, null: false
      t.boolean :pull, null: false
      t.text :body, null: false, default: ""

      t.timestamps
      t.index [:owner, :repo_name, :issue_number]
    end
  end
end
