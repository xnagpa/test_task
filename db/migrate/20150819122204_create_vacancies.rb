class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string :title
      t.datetime :till
      t.decimal :salary
      t.string :contacts

      t.timestamps null: false
    end
  end
end
