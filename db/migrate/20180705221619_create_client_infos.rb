class CreateClientInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :client_infos do |t|
      t.string :hatchery
      t.belongs_to :client, index: true

      t.timestamps
    end
  end
end
