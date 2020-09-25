class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.string :title
      t.string :created_by
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
