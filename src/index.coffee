require("./Framer")

famous = require("famous")

# Create layer, set properties
layerA = new Layer
    width: 80, height: 80, backgroundColor: "#7ed6ff", borderRadius: "4px"


# console.log "layerA.x: #{layerA.x}"
# console.log "layerA._element.getPosition(): #{layerA._element.getPosition()}"
# console.log "layerA._element.getOrigin(): #{layerA._element.getOrigin()}"
# console.log layerA._element.stateModifier

# console.log "setting x pos"
# layerA.x = 100

# layerA._element.stateModifier.setTransform(famous.core.Transform.translate(100, 100, 0))
# layerA._element.setPosition2(100, 100)



# Move down 300px
layerA.animate
  properties:
    y: 300
  
# # You can animate multiple properties at once
# layerB = new Layer
#   width: 80, height: 80, x: 100, backgroundColor: "#26b4f6", borderRadius: "4px"

# layerB.animate
#   properties:
#     y: 300
#     rotationZ: 360
#   # Duration of the animation
#   time: 2

# # Curve options describe the animation curve. The default is linear, but you can use others like "cubic-bezier" or "spring"
# layerC = new Layer
#   width: 80, height: 80, x: 200, backgroundColor: "#0079c6", borderRadius: "4px"

# layerC.animate
#   properties: 
#     y: 300
#   time: 3
#   curve: "cubic-bezier"