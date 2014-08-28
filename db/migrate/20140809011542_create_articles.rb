class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string  :title
      t.string  :slug
      t.string  :keyword
      t.text    :description
      t.text    :body
      t.string  :image_url
      t.integer :published
      t.integer :user_id
      t.integer :category_id
      t.timestamps
    end
  end
end
