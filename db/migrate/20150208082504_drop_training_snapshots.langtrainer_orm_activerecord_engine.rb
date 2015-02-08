# This migration comes from langtrainer_orm_activerecord_engine (originally 20150208081450)
class DropTrainingSnapshots < ActiveRecord::Migration
  def change
    drop_table :training_snapshots
  end
end
