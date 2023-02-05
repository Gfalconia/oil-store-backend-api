class RemoveImageFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :image, :string
  end
end
