require "./osmpbf_parser.rb"

module OSM
	class Element
		attr_accessor :id, :user, :uid, :visible, :version
		attr_reader :timestamp, :changeset
	
		def initialize(id, uid, user, version, timestamp, changeset, visible)
			# TODO make abstract class
			@id = id
			@uid = uid
			@user = user
			@version = version
			@timestamp = timestamp
			@changeset = changeset
			@visible = visible
		end
	end
	
	class Node < Element
		attr_accessor :tags
		attr_reader :lat, :lon
	
		def initialize(id, uid, user, timestamp, lat, lon, tags, version = nil, changeset = nil, visible = nil)
			@lat = lat
			@lon = lon
			@tags = tags
			super(id, uid, user, version, timestamp, changeset, visible)
		end
	
		def [](key)
			@tags[key]
		end
	
		def []=(key, value)
			@tags[key] = value
		end
	
		def type
			"node"
		end
	end
	
	class Way < Element
		attr_accessor :tags, :refs
	
		def initialize(id, uid, user, timestamp, tags, refs, version = nil, changeset = nil, visible = nil)
			@tags = tags
			@refs = refs
			super(id, uid, user, version, timestamp, changeset, visible)
		end
	
		def [](key)
			@tags[key]
		end
	
		def []=(key, value)
			@tags[key] = value
		end

		def nodes()
			@refs
		end
	
		def type
			"way"
		end
	end
end	
