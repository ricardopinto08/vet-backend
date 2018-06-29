class CreateExaminations < ActiveRecord::Migration[5.2]
  def change
    create_table :examinations do |t|
      t.belongs_to :audit, index: true
      t.string :title
      t.string :description
      t.string :city
      t.string :address
      t.datetime :start_hour
      t.datetime :end_hour

      t.float :current_weight
      t.float :current_chest
      t.float :current_umbilical
      t.float :current_shoulder
      t.float :current_olecranon
      t.float :current_height
      
      t.timestamps
    end
  end
end
