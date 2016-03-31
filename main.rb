#!/usr/bin/ruby

require "protobuf"
require "./osmpbf_parser.rb"

if ARGV.empty? then
	print "Please specify the osm pbf file\n"
	print "ex) #{__FILE__} test.osm.pbf"
	exit	
end

filename = ARGV[0]


def pause msg
	p msg 
	print "\n\nPress any key....\n\n"
	$stdin.gets
end

File.open(filename) { |stream|
	until stream.eof? do
		pause stream.pos

		bh = OSMPBFParser::BlobHeaderParser.get_blobheader stream
		pause bh
		b = OSMPBFParser::BlobParser.get_blob stream, bh
		pause b

		if bh.type == "OSMHeader" then
			block = OSMPBFParser::BlockParser.get_headerblock b 
		elsif bh.type == "OSMData" then
			block = OSMPBFParser::BlockParser.get_primitiveblock b 
		end
		pause block
	end
}
