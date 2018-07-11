extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Laserbolt

func _ready():
    # required from the 2nd wave onwards
    # TODO reload image
    
    # re-enable collision
    $TopLeftCollission.disabled = false
    $BottomLeftCollission.disabled = false
    $BottomRightCollission.disabled = false 
    $TopRightCollission.disabled = false  

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass


func _on_Barrier1_area_entered(area): 
    pass
    
func blast_away_pixels(LaserCoords, BlastDirection):
    $TextureRect._blast_barrier(LaserCoords, position, BlastDirection)

func _on_TextureRect_DisableTopLeftCollission():
    $TopLeftCollission.disabled = true

func _on_TextureRect_DisableBottomLeftCollission():
    $BottomLeftCollission.disabled = true

func _on_TextureRect_DisableBottomRightCollission():
    $BottomRightCollission.disabled = true   
    
func _on_TextureRect_DisableTopRightCollission():
    $TopRightCollission.disabled = true
