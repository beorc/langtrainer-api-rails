class CourseSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :slug
  )

  has_many :units
end
