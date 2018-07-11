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
    
    

func _blast_it(LaserCoords, BarrierCoords, BlastDirection):
    var SpriteXLocation
    var SpriteYLocation    
    var Xdifference
    var Ydifference
    var LaserBoltStrikeCoordX = LaserCoords.x
    var LaserBoltStrikeCoordY = 28 + LaserCoords.y
    
    # Difference between the strike point and the Barriers origin 
    if LaserBoltStrikeCoordX > BarrierCoords.x:
         Xdifference = LaserBoltStrikeCoordX - BarrierCoords.x
    else:
         Xdifference = BarrierCoords.x - LaserBoltStrikeCoordX    
    if LaserBoltStrikeCoordY > BarrierCoords.y:
         Ydifference = LaserBoltStrikeCoordY - BarrierCoords.y
    else:
         Ydifference = BarrierCoords.y - LaserBoltStrikeCoordY
    
    

    
func _blast_barrier(LaserCoords, BarrierCoords, BlastDirection):
    print("Laser coords: ", str(LaserCoords))
    print("Barrier coords: ", str(BarrierCoords))
    BarrierCoords.x = BarrierCoords.x - 55
    BarrierCoords.y = BarrierCoords.y - 40
    var SpriteXLocation
    var SpriteYLocation
    if (BlastDirection == "down"):
        # Actual coordinates of the laser bolt's strike point
        var LaserBoltStrikeCoordX = LaserCoords.x
        var LaserBoltStrikeCoordY = 28 + LaserCoords.y
        var Xdifference
        var Ydifference
        # Difference between the strike point and the Barriers origin 
        if LaserBoltStrikeCoordX >= BarrierCoords.x:
             Xdifference = LaserBoltStrikeCoordX - BarrierCoords.x
        else:
             Xdifference = 0 
        if LaserBoltStrikeCoordY >= BarrierCoords.y:
             Ydifference = LaserBoltStrikeCoordY - BarrierCoords.y
        else:
             Ydifference = 0
        
        # Now figure out where we are in the sprite
        var ActualBarrierWidth = 110 # pixels on the screen
        var ActualBarrierHeight = 80 # pixels on the screen  
        if Xdifference == 0:
            SpriteXLocation = 0
        else:
            SpriteXLocation = (Xdifference / ActualBarrierWidth) * 22 # (truncate?)
        if Ydifference == 0:
            SpriteYLocation = 0
        else:
            SpriteYLocation = (Ydifference / ActualBarrierHeight) * 16 # (truncate?)
        SpriteYLocation = 0 # TODO delete the above code to do with calculating the Y coord, as ir will always be 0
        #_write_pixel(SpriteXLocation, SpriteYLocation, BlastDirection)
    else:
        var LaserBoltStrikeCoordX = LaserCoords.x
        var LaserBoltStrikeCoordY = LaserCoords.y
        var Xdifference
        var Ydifference
        # Difference between the strike point and the Barriers origin 
        if LaserBoltStrikeCoordX > BarrierCoords.x:
             Xdifference = LaserBoltStrikeCoordX - BarrierCoords.x
        else:
             Xdifference = 0   
        if LaserBoltStrikeCoordY > (BarrierCoords.y + 80): # pixels have been increased by a factor of 5
             Ydifference = LaserBoltStrikeCoordY - (BarrierCoords.y + 80)
        else:
             Ydifference = 0
        
        # Now figure out where we are in the sprite
        var ActualBarrierWidth = 110
        var ActualBarrierHeight = 80  
        if Xdifference > 0:
            SpriteXLocation = (Xdifference / ActualBarrierWidth) * 21 # (truncate?)
        else:
            SpriteXLocation = 0
        if Ydifference > 0:
            SpriteYLocation = Ydifference / ActualBarrierHeight * 15 # (truncate?)
        else:
            SpriteYLocation = 15
        SpriteYLocation = 15 # TODO delete the above code to do with calculating the Y coord, as ir will always be 15
       # _write_pixel(SpriteXLocation, SpriteYLocation, BlastDirection)
    
    _write_pixel(SpriteXLocation, SpriteYLocation, BlastDirection)
        
func _write_pixel(SpriteXLocation, SpriteYLocation, BlastDirection):
    image.lock()
    var pixelColour = image.get_pixel(SpriteXLocation, SpriteYLocation)
    
    if BlastDirection == "down":
        while SpriteYLocation < 15 && pixelColour == destroyedPixel:
            # need to increase Y
            SpriteYLocation += 1
            # check if the pixel has been destroyed already
            pixelColour = image.get_pixel(SpriteXLocation, SpriteYLocation)
        # kill all pixels along Y
        var pixelsToDestroy = 5
        if SpriteXLocation - 2 >= 0:
            SpriteXLocation -= 2
        elif SpriteXLocation - 1 >= 0:
            SpriteXLocation -= 1
        var TotalRowsToDestroy = 5
        while TotalRowsToDestroy > 0:
            #pixelsToDestroy -= 1
            for pixel in pixelsToDestroy:  
                # destroy a line of pixels along the X axis    
                if randi()%11+1 < 8:                
                    image.set_pixel(round(SpriteXLocation + pixel), SpriteYLocation, Color(0.0, 0.0, 0.0, 0.0))
            SpriteYLocation += 1
            TotalRowsToDestroy -= 1
    else: # player gun shooting up the screen
        while SpriteYLocation > 0 && pixelColour == destroyedPixel:
            # need to increase Y
            SpriteYLocation -= 1
            # check if the pixel has been destroyed already
            pixelColour = image.get_pixel(SpriteXLocation, SpriteYLocation)
        # kill all pixels along Y
        var pixelsToDestroy = 5
        if SpriteXLocation - 2 >= 0:
            SpriteXLocation -= 2
        elif SpriteXLocation - 1 >= 0:
            SpriteXLocation -= 1
        var TotalRowsToDestroy = 5
        while TotalRowsToDestroy > 0:
            #pixelsToDestroy -= 1
            for pixel in pixelsToDestroy:  
                # destroy a line of pixels along the X axis    
                if randi()%11+1 < 8:                
                    image.set_pixel(round(SpriteXLocation + pixel), SpriteYLocation, Color(0.0, 0.0, 0.0, 0.0))
            SpriteYLocation -= 1
            TotalRowsToDestroy -= 1
        
    image.unlock()
    _write_image_back()
  
func _write_image_back():    
    imageTexture.create_from_image(image, 0) # 0 deatctivates filter?
    $BarrierSprite.texture = imageTexture


