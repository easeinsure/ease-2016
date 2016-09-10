class CreateNewsAndNotifications < ActiveRecord::Migration
  def change
    create_table :news_and_notifications do |t|
      t.string :name
      t.text :summary
      t.string :url
      t.datetime :published_at
      t.string :guid

      t.timestamps null: false
    end
  end
end
