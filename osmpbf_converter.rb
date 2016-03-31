require "./osm_object.rb"

# Convert OSMPBF::DenseNode to OSM::Node
def convert_dense_node block
	node_set = block.primitivegroup[0].dense
	string_table = block.stringtable.s
	
	decode_dense_nodes node_set, string_table
end

def decode_dense_nodes dense_nodes, string_table
	dense_info = dense_nodes.denseinfo
	node_range = 0..(dense_nodes.id.size - 1)
	kv_max = dense_nodes.keys_vals.size - 1

	id = 0

	uid = 0
	user_sid = 0
	timestamp = 0

	lat = 0
	lon = 0
	kv_now = 0

	changeset = 0
	visible = 0 

	node_range.map { |idx|
		uid += dense_info.uid[idx]
		user_sid += dense_info.user_sid[idx]
		timestamp += dense_info.timestamp[idx]
		version = dense_info.version[idx]
		changeset += dense_info.changeset[idx]
		visible += dense_info.visible[idx] if dense_info.visible.size > 0

		id += dense_nodes.id[idx]
		lat += dense_nodes.lat[idx]
		lon += dense_nodes.lon[idx]
		
		tags = {}

		(kv_now..kv_max)
			.take_while { |idx| dense_nodes.keys_vals[idx] != 0 } 
			.map { |idx| dense_nodes.keys_vals[idx] }
			.each_slice(2) { |pair| 
				tags[string_table[pair[0]]] = string_table[pair[1]]
			}


		if tags.size == 0 then
			kv_now += 1
		else
			kv_now += tags.size * 2
		end


		user = string_table[user_sid]

		if visible == 0 then
			OSM::Node.new(id, uid, user, timestamp, lat, lon, tags, version, changeset)
		else
			OSM::Node.new(id, uid, user, timestamp, lat, lon, tags, version, changeset, visible)
		end
	}
end


# Convert OSMPBF::Way to OSM::Way
def convert_dense_node block
	way_set = block.primitivegroup[0].ways
	string_table = block.stringtable.s
	
	decode_way way_set, string_table
end

def decode_way way_set, string_table
	way_set.map { |way|
		ref = 0
		refs = way.refs.map { |x| ref += x }

		tags = way.keys
				.zip(way.vals)
				.map { |x| x.map! { |y| string_table[y] } }
				.to_h

		if way.info == nil then
			OSM::Way.new(way.id, nil, nil, nil, tags, refs, nil, nil, nil)
		else
			# TODO local var in block
			OSM::Way.new(way.id, way.info.uid, string_table[way.info.user_sid], way.info.timestamp, tags, refs, way.info.version, way.info.changeset, way.info.visible)
		end
	}
end
