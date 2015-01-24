# This migration comes from langtrainer_orm_activerecord_engine (originally 20150124095303)
class RenameStepsToStepIdsInTrainings < ActiveRecord::Migration
  def change
    rename_column :trainings, :steps, :step_ids
  end
end
