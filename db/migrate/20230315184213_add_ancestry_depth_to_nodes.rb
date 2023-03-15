class AddAncestryDepthToNodes < ActiveRecord::Migration[7.0]
  def change
    add_column :nodes, :ancestry_depth, :integer
  end
end
