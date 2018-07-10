extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Laserbolt

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    #Laserbolt = get_tree().get_root().get_node("AutoLoad_name")
    pass

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass


func _on_Barrier1_area_entered(area): 
    pass
    
func blast_away_pixels(LaserCoords, BlastDirection):
    $TextureRect._blast_barrier(LaserCoords, position, BlastDirection)
