require "./osmpbf_parser.rb"

# Tool function

def load_data(filename="data/seoul_south-korea.osm.pbf") 
	bh, b, block = [], [], []

	File.open(filename) { |stream|
		until stream.eof? do
			stream.pos
	
			bh.push OSMPBFParser::BlobHeaderParser.get_blobheader stream
			b.push OSMPBFParser::BlobParser.get_blob(stream, bh[-1])
	
			if bh[-1].type == "OSMHeader" then
				block.push OSMPBFParser::BlockParser.get_headerblock b[-1] 
			elsif bh[-1].type == "OSMData" then
				block.push OSMPBFParser::BlockParser.get_primitiveblock b[-1] 
			end
		end
	}

	[bh, b, block]
end	
