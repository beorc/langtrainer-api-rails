class UnitSerializer < ActiveModel::Serializer
  attributes(:slug)

  delegate :current_user, to: :scope

  def current_step
    current_user.trainings.for_unit(object).first.fetch_current_step
  end
end
