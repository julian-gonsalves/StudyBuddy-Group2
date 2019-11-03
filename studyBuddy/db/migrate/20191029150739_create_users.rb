class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.text :description
      t.string :first_name
      t.string :last_name
      t.integer :phone_num

      t.timestamps
    end
  end
end
