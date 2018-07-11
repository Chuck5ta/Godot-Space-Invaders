extends Area2D

var Laserbolt

var image
var imageTexture
var imageSize = Vector2(22, 16)
var imageFormat = Image.FORMAT_RGH

func _ready():
    pass 

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass

    
func blast_away_pixels(LaserCoords, BlastDirection):
    $TextureRect._blast_barrier(LaserCoords, position, BlastDirection)
    
func _reenable_barrier():    
    # required from the 2nd wave onwards
    # TODO reload image
    $TextureRect._reload_image() 
