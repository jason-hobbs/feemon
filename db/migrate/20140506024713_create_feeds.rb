class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :site
      t.string :url

      t.timestamps
    end
  end
end
