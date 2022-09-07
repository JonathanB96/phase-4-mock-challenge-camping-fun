class CamperActivitiesSerializer < ActiveModel::Serializer
  attributes :id, :name, :difficulty
  has_many :activities

end
