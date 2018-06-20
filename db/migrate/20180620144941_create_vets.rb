class CreateVets < ActiveRecord::Migration[5.2]
  def change
    create_table :vets do |t|

      t.timestamps
    end
  end
end
