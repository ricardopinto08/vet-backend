class CreateAudits < ActiveRecord::Migration[5.2]
  def change
    create_table :audits do |t|
      t.belongs_to :horse, index: true
      t.belongs_to :vet, index: true
      t.datetime :end_date
      t.timestamps
    end
  end
end
