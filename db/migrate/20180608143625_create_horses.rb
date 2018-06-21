class CreateHorses < ActiveRecord::Migration[5.2]
  def change
    create_table :horses do |t|
      t.string :name
      t.datetime :born_date
      t.timestamps
    end
  end
end
