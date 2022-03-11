class CreateMusics < ActiveRecord::Migration[7.0]
  def change
    create_table :musics do |t|
      t.string :title
      t.string :artist
      t.timestamps null: true
    end
  end
end
