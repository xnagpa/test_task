class CreateVacancySkills < ActiveRecord::Migration
  def change
    create_table :vacancy_skills do |t|
      t.integer :vacancy_id
      t.integer :skill_id

      t.timestamps null: false
    end
  end
end
