class CreateHorses < ActiveRecord::Migration[5.2]
  def change
    create_table :horses do |t|
      t.string :name
      t.string :breed
      t.string :gender
      t.string :color
      t.datetime :born_date
      t.string :mom
      t.string :dad

      t.float :current_weight
      t.float :current_chest
      t.float :current_umbilical
      t.float :current_shoulder
      t.float :current_olecranon
      t.float :current_height

      t.float :born_weight
      t.float :born_chest
      t.float :born_umbilical
      t.float :born_shoulder
      t.float :born_olecranon
      t.float :born_height

      t.timestamps
    end
  end
end
