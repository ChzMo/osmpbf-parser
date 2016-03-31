# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf/message'

module OSMPBF

  ##
  # Message Classes
  #
  class HeaderBlock < ::Protobuf::Message; end
  class HeaderBBox < ::Protobuf::Message; end
  class PrimitiveBlock < ::Protobuf::Message; end
  class PrimitiveGroup < ::Protobuf::Message; end
  class StringTable < ::Protobuf::Message; end
  class Info < ::Protobuf::Message; end
  class DenseInfo < ::Protobuf::Message; end
  class ChangeSet < ::Protobuf::Message; end
  class Node < ::Protobuf::Message; end
  class DenseNodes < ::Protobuf::Message; end
  class Way < ::Protobuf::Message; end
  class Relation < ::Protobuf::Message
    class MemberType < ::Protobuf::Enum
      define :NODE, 0
      define :WAY, 1
      define :RELATION, 2
    end

  end



  ##
  # Message Fields
  #
  class HeaderBlock
    optional ::OSMPBF::HeaderBBox, :bbox, 1
    repeated :string, :required_features, 4
    repeated :string, :optional_features, 5
    optional :string, :writingprogram, 16
    optional :string, :source, 17
    optional :int64, :osmosis_replication_timestamp, 32
    optional :int64, :osmosis_replication_sequence_number, 33
    optional :string, :osmosis_replication_base_url, 34
  end

  class HeaderBBox
    required :sint64, :left, 1
    required :sint64, :right, 2
    required :sint64, :top, 3
    required :sint64, :bottom, 4
  end

  class PrimitiveBlock
    required ::OSMPBF::StringTable, :stringtable, 1
    repeated ::OSMPBF::PrimitiveGroup, :primitivegroup, 2
    optional :int32, :granularity, 17, :default => 100
    optional :int64, :lat_offset, 19, :default => 0
    optional :int64, :lon_offset, 20, :default => 0
    optional :int32, :date_granularity, 18, :default => 1000
  end

  class PrimitiveGroup
    repeated ::OSMPBF::Node, :nodes, 1
    optional ::OSMPBF::DenseNodes, :dense, 2
    repeated ::OSMPBF::Way, :ways, 3
    repeated ::OSMPBF::Relation, :relations, 4
    repeated ::OSMPBF::ChangeSet, :changesets, 5
  end

  class StringTable
    repeated :bytes, :s, 1
  end

  class Info
    optional :int32, :version, 1, :default => -1
    optional :int64, :timestamp, 2
    optional :int64, :changeset, 3
    optional :int32, :uid, 4
    optional :uint32, :user_sid, 5
    optional :bool, :visible, 6
  end

  class DenseInfo
    repeated :int32, :version, 1, :packed => true
    repeated :sint64, :timestamp, 2, :packed => true
    repeated :sint64, :changeset, 3, :packed => true
    repeated :sint32, :uid, 4, :packed => true
    repeated :sint32, :user_sid, 5, :packed => true
    repeated :bool, :visible, 6, :packed => true
  end

  class ChangeSet
    required :int64, :id, 1
  end

  class Node
    required :sint64, :id, 1
    repeated :uint32, :keys, 2, :packed => true
    repeated :uint32, :vals, 3, :packed => true
    optional ::OSMPBF::Info, :info, 4
    required :sint64, :lat, 8
    required :sint64, :lon, 9
  end

  class DenseNodes
    repeated :sint64, :id, 1, :packed => true
    optional ::OSMPBF::DenseInfo, :denseinfo, 5
    repeated :sint64, :lat, 8, :packed => true
    repeated :sint64, :lon, 9, :packed => true
    repeated :int32, :keys_vals, 10, :packed => true
  end

  class Way
    required :int64, :id, 1
    repeated :uint32, :keys, 2, :packed => true
    repeated :uint32, :vals, 3, :packed => true
    optional ::OSMPBF::Info, :info, 4
    repeated :sint64, :refs, 8, :packed => true
  end

  class Relation
    required :int64, :id, 1
    repeated :uint32, :keys, 2, :packed => true
    repeated :uint32, :vals, 3, :packed => true
    optional ::OSMPBF::Info, :info, 4
    repeated :int32, :roles_sid, 8, :packed => true
    repeated :sint64, :memids, 9, :packed => true
    repeated ::OSMPBF::Relation::MemberType, :types, 10, :packed => true
  end

end

