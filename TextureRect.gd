extends TextureRect

# Gonna try and use this to create destructible sprite image
var editableImage
var imageSize = Vector2(22, 16)
var imageFormat = Image.FORMAT_RGH

var imageTexture
var image

func _ready():
    var imageTexture = ImageTexture.new()
    var dynImage = Image.new()

    dynImage.create(imageSize.x,imageSize.y,imageFormat,0)
    dynImage.fill(Color(1,0,0,1))
    dynImage.lock()

    imageTexture.create_from_image(dynImage)
    self.texture = imageTexture

    imageTexture.resource_name = "The created texture!"
    print(self.texture.resource_name)    
    
    texture = ImageTexture.new()
    image = Image.new()
    # load up the sprite's image into image
  #  image = $Sprite.texture  
    #get_node("BarrierSprite").set_texture("res://Art/invader03b.png")
    #$BarrierSprite.texture = $Sprite.texture
    #$BarrierSprite.texture = load("res://Art/invader03b.png")
#    $BarrierSprite.texture = image
    image.create(imageSize.y,imageSize.y,imageFormat,0)
    image.load("res://Art/Barrier.png")
    image.lock()
    image.set_pixel(10, 8, Color(1.0, 0.0, 0.0, 0.0))
    image.set_pixel(10, 9, Color(1.0, 0.0, 0.0, 0.0))
    image.set_pixel(11, 8, Color(1.0, 0.0, 0.0, 0.0))
    image.set_pixel(11, 9, Color(1.0, 0.0, 0.0, 0.0))
    image.set_pixel(9, 9, Color(1.0, 0.0, 0.0, 0.0))
    image.unlock()
    
    imageTexture.create_from_image(image, 0) # 0 deatctivates filter?
    $BarrierSprite.texture = imageTexture

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass

func _set_pixel():
    # image.set_pixel(x, y, color)
    pass
    
    
