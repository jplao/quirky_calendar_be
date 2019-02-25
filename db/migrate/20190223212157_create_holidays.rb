class CreateHolidays < ActiveRecord::Migration[5.2]
  def change
    create_table :holidays do |t|
      t.datetime :date
      t.string :name
      t.string :url
    end
  end
end
