class AddImageFileNameMiniToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :image_file_name_mini, :string
  end
end
