class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :pnum
      t.string :notes

      t.timestamps null: false
    end
  end
end
