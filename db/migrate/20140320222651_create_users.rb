class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :age
      t.string :phone
      t.references :doctor_id
      t.references :account_id
    end
  end
end
