# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `kaminari-activerecord` gem.
# Please instead update this file by running `bin/tapioca gem kaminari-activerecord`.


# source://kaminari-activerecord//lib/kaminari/activerecord/version.rb#3
module Kaminari; end

# source://kaminari-activerecord//lib/kaminari/activerecord/active_record_extension.rb#6
module Kaminari::ActiveRecordExtension
  extend ::ActiveSupport::Concern

  mixes_in_class_methods ::Kaminari::ActiveRecordExtension::ClassMethods
end

# source://kaminari-activerecord//lib/kaminari/activerecord/active_record_extension.rb#9
module Kaminari::ActiveRecordExtension::ClassMethods
  # Future subclasses will pick up the model extension
  #
  # source://kaminari-activerecord//lib/kaminari/activerecord/active_record_extension.rb#11
  def inherited(kls); end
end

# source://kaminari-activerecord//lib/kaminari/activerecord/active_record_model_extension.rb#6
module Kaminari::ActiveRecordModelExtension
  extend ::ActiveSupport::Concern
  include ::Kaminari::ConfigurationMethods

  mixes_in_class_methods ::Kaminari::ConfigurationMethods::ClassMethods
end

# Active Record specific page scope methods implementations
#
# source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#5
module Kaminari::ActiveRecordRelationMethods
  # Used for page_entry_info
  #
  # source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#7
  def entry_name(options = T.unsafe(nil)); end

  # source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#12
  def reset; end

  # source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#17
  def total_count(column_name = T.unsafe(nil), _options = T.unsafe(nil)); end

  # Turn this Relation to a "without count mode" Relation.
  # Note that the "without count mode" is supposed to be performant but has a feature limitation.
  #   Pro: paginates without casting an extra SELECT COUNT query
  #   Con: unable to know the total number of records/pages
  #
  # source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#50
  def without_count; end
end

# source://kaminari-activerecord//lib/kaminari/activerecord/version.rb#4
module Kaminari::Activerecord; end

# source://kaminari-activerecord//lib/kaminari/activerecord/version.rb#5
Kaminari::Activerecord::VERSION = T.let(T.unsafe(nil), String)

# A module that makes AR::Relation paginatable without having to cast another SELECT COUNT query
#
# source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#56
module Kaminari::PaginatableWithoutCount
  # The page wouldn't be the last page if there's "limit + 1" record
  #
  # @return [Boolean]
  #
  # source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#109
  def last_page?; end

  # Overwrite AR::Relation#load to actually load one more record to judge if the page has next page
  # then store the result in @_has_next ivar
  #
  # source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#90
  def load; end

  # Empty relation needs no pagination
  #
  # @return [Boolean]
  #
  # source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#114
  def out_of_range?; end

  # Force to raise an exception if #total_count is called explicitly.
  #
  # source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#120
  def total_count; end
end

# source://kaminari-activerecord//lib/kaminari/activerecord/active_record_relation_methods.rb#57
module Kaminari::PaginatableWithoutCount::LimitValueSetter; end
