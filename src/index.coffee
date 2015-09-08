Logger  = require('./Logger')
Layer = require("./Layer")
BackgroundLayer = require("./BackgroundLayer")
Application = require('./Application')
Events = require('./Events')

Clock = require("./Clock")

Application.run ->    

    # Create layer, set properties
    layerA = new Layer
      width: 80, height: 80, backgroundColor: "#7ed6ff", borderRadius: "4px"

    # Move down 300px
    layerA.animate
      properties:
        y: 300
      
    # You can animate multiple properties at once
    layerB = new Layer
      width: 80, height: 80, x: 100, backgroundColor: "#26b4f6", borderRadius: "4px"

    layerB.animate
      properties:
        y: 300
        rotationZ: 360
      # Duration of the animation
      time: 2

    # Curve options describe the animation curve. The default is linear, but you can use others like "cubic-bezier" or "spring"
    layerC = new Layer
      width: 80, height: 80, x: 200, backgroundColor: "#0079c6", borderRadius: "4px"

    layerC.animate
      properties: 
        y: 300
      time: 3
      curve: "outCubic"