class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_associations(auth_object = nil)
    reflections.keys
  end

  def self.ransackable_attributes(auth_object = nil)
    attribute_names
  end
end
