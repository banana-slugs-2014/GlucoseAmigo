class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :user_id
      t.string :weight
      t.string :glucose
      t.datetime :take_at
      t.timestamps
    end
  end
end
