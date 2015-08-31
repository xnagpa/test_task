class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :name
      t.string :contacts
      t.string :status
      t.decimal :salary

      t.timestamps null: false
    end
  end
end
