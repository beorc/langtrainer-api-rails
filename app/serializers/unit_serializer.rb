class UnitSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :slug,
    :random_steps_order
  )
end
