class CourseSerializer < ActiveModel::Serializer
  attributes(:slug)

  has_many :units
end
