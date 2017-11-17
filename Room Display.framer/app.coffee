# Import file "BukaRuang"
sketch1 = Framer.Importer.load("imported/BukaRuang@1x", scale: 1)
# Import file "Bukalapak"
sketch = Framer.Importer.load("imported/Bukalapak@1x", scale: 1)

# Set Device background
Screen.backgroundColor = null
Canvas.image = "images/ruang.jpg"

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
			status: 1
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
			attendee: [
				{ user_id: 1 }
				{ user_id: 2 }
				{ user_id: 3 }
			]
			date: "18 November 2017"
			time_start: "18:30"
			time_end: "20:30"
			status: "Not yet started"
		}
]

usersData = [
		{
			user_id: 1
			name: "Afnizar Nur Ghifari"
			email: "afnizar.hilmi@bukalapak.com"
			avatar: "https://firebasestorage.googleapis.com/v0/b/bukaruang.appspot.com/o/500x500.jpg?alt=media&token=167fffaf-292c-48c3-b534-5759f2073868"
			status: "user"
		}
		
		{
			user_id: 2
			name: "Hendrawan Fernando"
			email: "hendrawan.fernando@bukalapak.com"
			avatar: "https://firebasestorage.googleapis.com/v0/b/bukaruang.appspot.com/o/1-dT_mJBVOjtwIywZ0Csi6SQ.jpeg?alt=media&token=b7d431de-7a36-4154-96fd-58ae7938cf08"
			status: "user"
		}
		
		{
			user_id: 3
			name: "Adwin Dito"
			email: "adwin.dito@bukalapak.com"
			avatar: "https://firebasestorage.googleapis.com/v0/b/bukaruang.appspot.com/o/images.jpeg?alt=media&token=0f35828a-c7e7-4b44-bcfe-26b619943c14"
			status: "user"
		}
]

	
bukaruang_db.put("/ruang", ruangData)
bukaruang_db.put("/amenities", amenitiesData)
bukaruang_db.put("/meeting", meetingData)
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
sketch.header.children[0].opacity = 0
sketch.header.children[1].opacity = 0	
sketch.Status.children[0].opacity = 0
sketch.Status.children[0].y = Screen.height
sketch.Status.children[1].opacity = 0
sketch.Status.children[1].y = Screen.height	

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
			time: 0.3

	if value.status is 1 
		sketch.Status.children[0].animate
			opacity: 1
			y: 0
			options: 
				time: 0.4
		sketch.header.children[1].opacity = 1
		sketch.Status.children[1].opacity = 0
		sketch.header.children[0].opacity = 0
	else if value.status is 0
		sketch.Status.children[0].opacity = 0
		sketch.header.children[1].opacity = 0
		sketch.Status.children[1].animate
			opacity: 1
			y: 0
			options: 
				time: 0.4
		sketch.header.children[0].opacity = 1

showAvatarById = (param) ->
	bukaruang_db.get "/users", (avatars) ->
		avatarsArray = _.toArray(avatars) # converts JSON to array
		for avatar in avatarsArray
			if avatar.user_id is param 
				return avatar.avatar
				
bukaruang_db.get "/meeting/0", (value) ->
	n = 0
	y = 1
	while n < value.attendee.length
		avatarAttendee = new Layer
			x: 124 + 65 * n
			y: 739 
			width: 57
			height: 57
			parent: sketch.$01_Room_Display_In_Use
			backgroundColor: "transparent"
			image: showAvatarById(y)
			borderRadius: 28.5
			borderColor: "rgba(255,255,255,1)"
			borderWidth: 7
		y++
		n++
			
	meeting_name = new TextLayer
		x: 123
		y: 350
		text: value.desc
		parent: sketch.$01_Room_Display_In_Use
		fontSize: 96
		opacity: 0
		fontFamily: "Noto Sans"
		fontWeight: 700
		textAlign: "left"
		color: "rgba(238,238,238,1)"
		
	meeting_time = new TextLayer
		x: 123
		y: 577
		parent: sketch.$01_Room_Display_In_Use
		text: "#{value.time_start} - #{value.time_end}"
		fontSize: 36
		fontFamily: "Noto Sans"
		textAlign: "left"
		color: "rgba(238,238,238,1)"
		opacity: 0.800000011920929
		
	meeting_name.animate
		opacity: 1
		y: 414
		options: 
			time: 0.3
# 
sketch.Menu.onClick (event, layer) ->
	sketch.$01_Room_Display_In_Use.animate 
		blur: 10
		options:
			time: 0.2
			curve: Bezier.ease
			
sketch.$01_Room_Display_In_Use.onClick (event, layer) ->
	this.animate
		blur: 0
		options:
			time: 0.2
			curve: Bezier.ease
	
	
