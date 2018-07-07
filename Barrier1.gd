extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass


func _test():
    $BarrierSprite.visible = true
    #$BarrierSprite.texture.


func _on_Barrier1_area_entered(area):    
    var ArrayOfOverlaps = get_overlapping_areas() 
    print("************************* SOMETHING HIT US **********************")
    print("************************* SOMETHING HIT US **********************")
    print("************************* SOMETHING HIT US **********************")
    print("************************* SOMETHING HIT US **********************")
    print("************************* SOMETHING HIT US **********************")
    print("************************* SOMETHING HIT US **********************")
    for item in ArrayOfOverlaps:
        print(item)    
    print("************************* SOMETHING HIT US **********************")
    print("************************* SOMETHING HIT US **********************")
    print("************************* SOMETHING HIT US **********************")
    print("************************* SOMETHING HIT US **********************")
    print("************************* SOMETHING HIT US **********************")
    print("************************* SOMETHING HIT US **********************")
    
