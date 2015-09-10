class AddSlideGroupIdToSlides < ActiveRecord::Migration
  def change
    add_column :spree_slides, :slide_group_id, :integer, :null => false, :default => 0
  end
end
