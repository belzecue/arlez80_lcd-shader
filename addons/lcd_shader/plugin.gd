tool
extends EditorPlugin

func _enter_tree():
	self.add_custom_type( "LCD", "ColorRect", preload("LCDScript.gd"), preload("icon.png") )

func _exit_tree():
	self.remove_custom_type( "LCD" )

func get_plugin_name( ):
	return "LCD Shader"
