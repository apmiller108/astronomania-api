class ApodSerializer < ActiveModel::Serializer
  attributes :copyright,
             :date,
             :explanation,
             :hdurl,
             :media_type,
             :title,
             :url
end
