class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :First_Name
      t.string :Last_Name
      t.text :Email
      t.string :Phone_Number
      t.text :Notes

      t.timestamps null: false
    end
  end
end
