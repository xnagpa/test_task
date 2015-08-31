class CreateWorkerSkills < ActiveRecord::Migration
  def change
    create_table :worker_skills do |t|
      t.integer :worker_id
      t.integer :skill_id

      t.timestamps null: false
    end
  end
end
