class AddImageToAnnexeds < ActiveRecord::Migration[5.2]
  def change
    add_column :annexeds, :image, :string
  end
end
