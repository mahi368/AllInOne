class AddAvatarToImages < ActiveRecord::Migration[5.2]
  def up
    add_attachment :images, :avatar
  end
 
  def down
    remove_attachment :images, :avatar
  end
end
