class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.boolean :reminders
      t.references :user_id
    end
  end
end
