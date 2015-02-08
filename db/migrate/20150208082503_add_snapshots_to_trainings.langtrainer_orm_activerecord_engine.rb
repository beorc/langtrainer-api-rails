# This migration comes from langtrainer_orm_activerecord_engine (originally 20150208081349)
class AddSnapshotsToTrainings < ActiveRecord::Migration
  def change
    add_column :trainings, :snapshots, :text
  end
end
