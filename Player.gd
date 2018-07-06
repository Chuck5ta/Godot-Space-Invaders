extends Area2D

signal hit
export (int) var SPEED  # how fast the player will move (pixels/sec)
var screensize  # size of the game window
var PlayerAlive = true
# Used for resetting the Plaer
var StartPositionX = 0;
var StartPositionY = 0;

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # store position
    StartPositionX = position.x
    StartPositionY = position.y
    screensize = get_viewport_rect().size
    $AnimatedSprite.visible = false 

func _process(delta):
    if (PlayerAlive):
        var velocity = Vector2() # the player's movement vector
        if Input.is_action_pressed("ui_right"):
            velocity.x += 1
        if Input.is_action_pressed("ui_left"):
            velocity.x -= 1
        if velocity.length() > 0:
            velocity = velocity.normalized() * SPEED
        position += velocity * delta
        position.x = clamp(position.x, 0, screensize.x)
        position.y = clamp(position.y, 0, screensize.y)
    
# Run at the start of a new level
func _reset_player_scene():
    show()  
    $PlayerSprite.show()
    $PlayerSprite.visible = true 
    position.x = StartPositionX
    position.y = StartPositionY
    PlayerAlive = true
    $CollisionShape2D.disabled = false

func _on_ExplosionTimer_timeout():
    # Hide the scene
    hide()  
    $AnimatedSprite.stop() 
    $AnimatedSprite.visible = false
    $PlayerSprite.visible = true  
    $ExplosionTimer.stop()


func _on_Player_area_entered(area):
    print("PLAYER GUN HIT!!!!")
    if (PlayerAlive): # used to prevent double kill (2 lives lost) at the same time
        $CollisionShape2D.disabled = true
        PlayerAlive = false
        # hide animation  
        $PlayerSprite.visible = false 
        $AnimatedSprite.visible = true    
        $AnimatedSprite.play()  
        $ExplosionSound.play()
        $ExplosionTimer.start()
        yield($ExplosionTimer, "timeout")
        emit_signal("hit") 
