class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies, id :uuid do |t|

      t.string :title
      t.string :producer
      t.string :genre
      t.string :year
      t.integer :rating
      t.string :urlink
      t.text :synopsys
      t.string :urlandscape
    end
  end
end
