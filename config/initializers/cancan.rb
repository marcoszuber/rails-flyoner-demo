#require_dependency 'cancan/model_adapters/active_record_4_adapter'
#
#if defined?(CanCan)
#  class Object
#    def metaclass
#      class << self; self; end
#    end
#  end
#
#  module CanCan
#    module ModelAdapters
#      class ActiveRecord4Adapter < ActiveRecordAdapter
#        @@friendly_support = {}
#
#        def self.find(review_aircraft, id)
#          klass =
#              review_aircraft.metaclass.ancestors.include?(ActiveRecord::Associations::CollectionProxy) ?
#                  review_aircraft.klass : review_aircraft
#          @@friendly_support[klass]||=klass.metaclass.ancestors.include?(FriendlyId)
#          @@friendly_support[klass] == true ? review_aircraft.friendly.find(id) : review_aircraft.find(id)
#        end
#      end
#    end
#  end
#end