# Import file "BukaRuang"
sketch = Framer.Importer.load("imported/BukaRuang@1x", scale: 1)
# Set Device background
Screen.backgroundColor = null
Canvas.image = "images/ruang.jpg"

flow = new FlowComponent

flow.showNext(sketch.home1)

sketch.Group_8.onClick ->
	flow.showNext(sketch.buat_event_baru)
	
sketch.nyoba.onClick ->
	flow.showNext(sketch.buat_event_baru1)