class CreateApod < ActiveRecord::Migration[5.1]
  def change
    create_table :apods do |t|
      t.string :copyright
      t.date :date, null: false, index: true
      t.text :explanation, null: false
      t.string :hdurl
      t.string :media_type
      t.string :service_version
      t.string :title, null: false
      t.string :url, null: false
      t.timestamps
    end
  end
end
