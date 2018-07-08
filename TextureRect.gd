extends TextureRect

# Gonna try and use this to create destructible sprite image
var editableImage
var imageSize = Vector2(22, 16)
var imageFormat = Image.FORMAT_RGH

var imageTexture
var image
var destroyedPixel = Color(0, 0, 0, 0)

func _ready():
    randomize()
    imageTexture = ImageTexture.new()
    image = Image.new()
    image.create(imageSize.y,imageSize.y,imageFormat,0)
    image.load("res://Art/Barrier.png")

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass
    
func _blast_barrier(LaserCoords, BarrierCoords):
    print("Laser coords: ", str(LaserCoords))
    print("Barrier coords: ", str(BarrierCoords))
    # Actual coordinates of the laser bolt's strike point
    var LaserBoltStrikeCoordX = 12 + LaserCoords.x
    var LaserBoltStrikeCoordY = 28 + LaserCoords.y
    var Xdifference
    var Ydifference
    # Difference between the strike point and the Barriers origin 
    if LaserBoltStrikeCoordX > BarrierCoords.x:
         Xdifference = LaserBoltStrikeCoordX - BarrierCoords.x
    else:
         Xdifference = BarrierCoords.x - LaserBoltStrikeCoordX    
    if LaserBoltStrikeCoordY > BarrierCoords.y:
         Ydifference = LaserBoltStrikeCoordY - BarrierCoords.y
    else:
         Ydifference = BarrierCoords.y - LaserBoltStrikeCoordY
    
   # Now figure out where we are in the sprite
    var ActualBarrierWidth = 110
    var ActualBarrierHeight = 80    
    var SpriteXLocation =  Xdifference / ActualBarrierWidth * 22 # (truncate?)
    var SpriteYLocation =  Ydifference / ActualBarrierHeight * 16 # (truncate?)
    _write_pixel(SpriteXLocation, SpriteYLocation)
  

func _write_pixel(SpriteXLocation, SpriteYLocation):
    image.lock()
    # check if the pixel has been destroyed already
    var pixelColour = image.get_pixel(SpriteXLocation, SpriteYLocation)
    
    while SpriteYLocation < 15 && pixelColour == destroyedPixel:
            # need to increase Y
            SpriteYLocation += 1
    # kill all pixels along Y
    var pixelsToDestroy = 10
    for y in SpriteYLocation:
        #pixelsToDestroy -= 1
        for pixel in pixelsToDestroy:  
            # destroy a line of pixels along the X axis    
            if randi()%11+1 < 8:                
                image.set_pixel(round(SpriteXLocation + pixel), y, Color(0.0, 0.0, 0.0, 0.0))
    image.unlock()
    _write_image_back()
  
    
func _write_image_back():    
    imageTexture.create_from_image(image, 0) # 0 deatctivates filter?
    $BarrierSprite.texture = imageTexture

    
    
    
