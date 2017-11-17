# Import file "Bukalapak"
sketch = Framer.Importer.load("imported/Bukalapak@1x", scale: 1)

# Set Device background
Screen.backgroundColor = null
Canvas.image = "images/wood.jpg"

# Firebase Configuration
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

meetingData = [
		{
			meeting_id: 1
			ruang_id: 1
			desc: "UI Weekly Meetup"
			organizer: 1
			date: "18 November 2017"
			time_start: "18:30"
			time_end: "20:30"
			status: "Not yet started"
		}
]

attendeeData = [
		{
			meeting_id: 1
			attendee: [
				{ user_id: 1 }
				{ user_id: 2 }
				{ user_id: 3 }
			]
		}
]

usersData = [
		{
			user_id: 1
			name: "Afnizar"
			email: "afnizar.hilmi@bukalapak.com"
			avatar: "https://firebasestorage.googleapis.com/v0/b/bukaruang.appspot.com/o/500x500.jpg?alt=media&token=167fffaf-292c-48c3-b534-5759f2073868"
			status: "user"
		}
]

	
bukaruang_db.put("/ruang", ruangData)
bukaruang_db.put("/amenities", amenitiesData)
bukaruang_db.put("/meeting", meetingData)
bukaruang_db.put("/attendee", attendeeData)
bukaruang_db.put("/users", usersData)

timeNow = new TextLayer
	x: 1064
	y: 115
	fontSize: 48
	fontFamily: "Noto Sans"
	fontWeight: 700
	letterSpacing: 0.0
	parent: sketch.$01_Room_Display_In_Use
	textAlign: "right"
	color: "rgba(238,238,238,1)"
	
todayDate = new TextLayer
	x: 895
	y: 185
	fontSize: 24
	fontFamily: "Noto Sans"
	parent: sketch.$01_Room_Display_In_Use
	letterSpacing: 0.0
	textAlign: "right"
	color: "rgba(238,238,238,1)"
	opacity: 0.800000011920929
	

# Time Right Now
setTime = () ->
	date = new Date
	minute = date.getMinutes()
	hour = date.getHours()
	
	if hour < 10
		hour = '0' + hour 
	
	if minute < 10
		minute = '0' + minute 

	timeNow.text = "#{hour}:#{minute}"

	Utils.delay 30, ->
		setTime()

setTime()
	
# Date
setDate = () ->
	today = new Date
	dd = today.getDate()
	dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
	dm = dayNames[today.getDay() - 1]
	yy = today.getFullYear()
	monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	mm = monthNames[today.getMonth()];
	todayDate.text = "#{dm}, #{dd} #{mm} #{yy}"

setDate()

todayDate.Align = "right"

bukaruang_db.get "/ruang/0", (value) ->
	room_name = new TextLayer
		x: 126
		y: 300
		text: value.name
		fontSize: 36
		parent: sketch.$01_Room_Display_In_Use
		fontFamily: "Noto Sans"
		fontWeight: 700
		textAlign: "left"
		opacity: 0
		color: "rgba(238,238,238,1)"
		
	room_name.animate
		opacity: 1
		y: 365
		options: 
			time: 0.5
		
bukaruang_db.get "/meeting/0", (value) ->
	meeting_name = new TextLayer
		x: 123
		y: 360
		text: value.desc
		parent: sketch.$01_Room_Display_In_Use
		fontSize: 96
		fontFamily: "Noto Sans"
		fontWeight: 700
		textAlign: "left"
		color: "rgba(238,238,238,1)"
		
	meeting_name.animate
		opacity: 1
		y: 414
		options: 
			time: 0.5
		

	
