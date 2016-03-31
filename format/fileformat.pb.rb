# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf/message'

module OSMPBF

  ##
  # Message Classes
  #
  class Blob < ::Protobuf::Message; end
  class BlobHeader < ::Protobuf::Message; end


  ##
  # Message Fields
  #
  class Blob
    optional :bytes, :raw, 1
    optional :int32, :raw_size, 2
    optional :bytes, :zlib_data, 3
    optional :bytes, :lzma_data, 4
    optional :bytes, :OBSOLETE_bzip2_data, 5, :deprecated => true
  end

  class BlobHeader
    required :string, :type, 1
    optional :bytes, :indexdata, 2
    required :int32, :datasize, 3
  end

end

