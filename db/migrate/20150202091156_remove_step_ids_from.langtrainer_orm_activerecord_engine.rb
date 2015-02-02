# This migration comes from langtrainer_orm_activerecord_engine (originally 20150202082943)
class RemoveStepIdsFrom < ActiveRecord::Migration
  def change
    remove_column :trainings, :step_ids
    remove_column :trainings, :revised
  end
end
