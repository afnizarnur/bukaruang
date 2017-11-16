{Firebase} = require 'firebase'

bukaruang_db = new Firebase
	projectID: 'bukaruang'
	secret: 'Ew3OhucUyNFybjcexsnB1mxjzMZLotstG1BYzBaE'

# Database Seeder
ruangData = [
		{
			ruang_id: 1
			name: "Blue Room"
			desc: "Deskripsi tentang Blue Room"
			capacity: "20"
			location: "Plaza City View"
			status: "In Use"
		}
	]	
	
amenitiesData = [
		{
			ruang_id: 1
			amenities: {
				ac: "yes"
				proyektor: "yes"
				tv: "yes"
				meja: "yes"
				kursi: "yes"
			}
		}
]
	
# response = (confirmation) ->
# 	print confirmation
	
bukaruang_db.put("/ruang", ruangData)
bukaruang_db.put("/amenities", amenitiesData)

# 	
# bukaruang_db.get "/ruang", (value) ->
# 	print value.available
