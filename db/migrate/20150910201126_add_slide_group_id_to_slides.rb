class AddSlideGroupIdToSlides < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_slides, :slide_group_id, :integer, :null => false, :default => 0
  end
end
