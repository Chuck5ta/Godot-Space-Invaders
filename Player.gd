extends RigidBody2D

signal hit
export (int) var SPEED  # how fast the player will move (pixels/sec)
var screensize  # size of the game window
var PlayerAlive = true

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
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


func _on_Player_body_entered(body):
    print("Player has been hit!!")
    PlayerAlive = false
    # hide animation  
    $Sprite.visible = false 
    $AnimatedSprite.visible = true    
    $AnimatedSprite.play()  
    $ExplosionSound.play()
    $ExplosionTimer.start()
    $CollisionShape2D.disabled = true
    emit_signal("hit")


func _on_ExplosionTimer_timeout():
    # Hide the scene
    hide()  
    $AnimatedSprite.stop() 
    $AnimatedSprite.visible = false
    $Sprite.visible = true   
    #queue_free()