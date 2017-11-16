{Firebase} = require 'firebase'

bukaruang_db = new Firebase
	projectID: 'bukaruang'
	secret: 'Ew3OhucUyNFybjcexsnB1mxjzMZLotstG1BYzBaE'

ruangData = {
		ruang_id: "1"
		ruang_name: "Blue Room"
	}	
	
response = (confirmation) ->
	print confirmation
	
bukaruang_db.put("/ruang", ruangData, response)

	
bukaruang_db.get "/ruang", (value) ->
	print value.available
