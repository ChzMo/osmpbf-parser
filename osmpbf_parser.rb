require "protobuf"
require "zlib"
require "./format/fileformat.pb.rb"
require "./format/osmformat.pb.rb"

module OSMPBFParser
	class BlobHeaderParser
		class << self
			def get_blobheader stream
				len = parse_length(stream)
				buf = stream.readpartial(len)
				stringio = StringIO.new(buf)
	
				OSMPBF::BlobHeader.decode_from stringio
			end
	
			private
	
			def parse_length stream
				buf = stream.readpartial(4)
				buf = buf.unpack("H*")
	
				buf[0].hex
			end
		end
	end
	
	class BlobParser
		class << self
			def get_blob stream, blob_header
				buf = stream.readpartial(blob_header.datasize)
				stringio = StringIO.new(buf)
	
				OSMPBF::Blob.decode_from stringio
			end
		end
	end
	
	class BlockParser
		class << self
			def get_headerblock blob
				data = fetch_data_from blob
	
				OSMPBF::HeaderBlock.decode_from data 
			end
	
			def get_primitiveblock blob
				data = fetch_data_from blob

				OSMPBF::PrimitiveBlock.decode_from data 
			end
	
			private
	
			def fetch_data_from blob
				if !blob.raw.empty? then 
					stringio = StringIO.new(blob.raw)
				elsif !blob.zlib_data.empty? then
					uncomp = Zlib::Inflate.inflate blob.zlib_data
					raise "Invalid Data - the size of uncompressed data is not equal to raw_size." if uncomp.size != blob.raw_size
					stringio = StringIO.new(uncomp)
				end
				
				stringio
			end
		end
	end
end
