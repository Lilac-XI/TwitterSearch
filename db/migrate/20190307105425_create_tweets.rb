class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|

      t.text :text
      t.string :account_name
      t.string :account_icon_url
      t.string :account_id
      t.date :date
      t.string :time
      t.string :search_word
      t.string :tweet_id
      t.integer :rt
      t.integer :fav
      t.string :url


      t.timestamps
    end
  end
end
