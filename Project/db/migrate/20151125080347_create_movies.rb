class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :producer
      t.string :genre
      t.string :year
      t.integer :rating
      t.string :urlink
      t.text :synopsys
    end
  end
end
