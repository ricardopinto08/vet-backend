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
      t.timestamps
    end
  end
end
