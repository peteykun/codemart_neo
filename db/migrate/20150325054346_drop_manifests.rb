class DropManifests < ActiveRecord::Migration
  def change
    drop_table :manifests
  end
end
