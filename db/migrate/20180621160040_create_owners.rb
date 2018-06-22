class CreateOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :owners do |t|
      t.belongs_to :horse, index: true
      t.belongs_to :client, index: true
      t.datetime :endDate
      t.timestamps
    end
  end
end
