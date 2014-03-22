class CreateDiabetics < ActiveRecord::Migration
  def change
    create_table :diabetics do |t|
      t.string :name, :email, :null => false
      t.date :birthday
      t.boolean :confirmed
      t.belongs_to :doctor
      t.belongs_to :account
    end
  end
end
