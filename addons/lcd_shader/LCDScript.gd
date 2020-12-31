extends ColorRect

var previous_screen_buffer:ImageTexture = null

# 残像の強さ
export(float, 0.0, 1.0) var residual_image_rate:float = 0.95 setget _set_residual_image_rate
# ディザリング
export(float, 0.0, 1.0) var dithering:float = 0.1 setget _set_dithering
# カラー液晶
export(bool) var color_lcd:bool = false setget _set_color_lcd
# モノクロ液晶（明るいほう）
export(Color) var monochrome_light:Color = Color( 0.5372549019607843, 0.6274509803921569, 0.34765625, 1.0 ) setget _set_monochrome_light
# モノクロ液晶（暗くなるほう）
export(Color) var monochrome_dark:Color = Color( 0.19607843137254902, 0.22745098039215686, 0.1450980392156863, 1.0 ) setget _set_monochrome_dark
# 液晶発色段階数
export(int, 2, 255) var steps:int = 4 setget _set_steps

func _init( ):
	self.material = ShaderMaterial.new( )
	self.material.shader = preload("lcd.shader")

func _ready( ):
	self.visible = true
	self.previous_screen_buffer = ImageTexture.new( )
	self.material.set_shader_param( "residual_image_tex", self.previous_screen_buffer )

func _set_residual_image_rate( _residual_image_rate:float ) -> float:
	residual_image_rate = _residual_image_rate
	self.material.set_shader_param( "residual_image_rate", residual_image_rate )
	return residual_image_rate

func _set_dithering( _dithering:float ) -> float:
	dithering = _dithering
	self.material.set_shader_param( "dithering", dithering )
	return dithering

func _set_color_lcd( _color_lcd:bool ) -> bool:
	color_lcd = _color_lcd
	self.material.set_shader_param( "color_lcd", color_lcd )
	return color_lcd

func _set_monochrome_light( _monochrome_light:Color ) -> Color:
	monochrome_light = _monochrome_light
	self.material.set_shader_param( "monochrome_light", monochrome_light )
	return monochrome_light

func _set_monochrome_dark( _monochrome_dark:Color ) -> Color:
	monochrome_dark = _monochrome_dark
	self.material.set_shader_param( "monochrome_dark", monochrome_dark )
	return monochrome_dark

func _set_steps( _steps:int ) -> int:
	steps = _steps
	self.material.set_shader_param( "steps", steps )
	return steps

func _process( delta:float ):
	var image:Image = self.get_viewport( ).get_texture( ).get_data( )
	image.flip_y( )
	self.previous_screen_buffer.create_from_image( image, 4 )
