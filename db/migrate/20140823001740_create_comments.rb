class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.string :website
      t.text :body
      t.integer :article_id
      t.integer :enabled, :default => 0

      t.timestamps
    end
  end
end
