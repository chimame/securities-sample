class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :url
      t.integer :twitter_count
      t.integer :facebook_count
      t.integer :hatebu_count

      t.timestamps
    end
  end
end
