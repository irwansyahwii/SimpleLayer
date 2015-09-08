Logger  = require('./Logger')
Layer = require("./Layer")
BackgroundLayer = require("./BackgroundLayer")
Application = require('./Application')
Events = require('./Events')

Application.run ->    

    # Set background
    bg = new BackgroundLayer backgroundColor: "#28affa"
    bg.bringToFront()

    # Create layer
    layerA = new Layer
        width: 250
        height: 250
        backgroundColor: "#fff"
        borderRadius: 8
        
    layerA.center()
        
    # Rotate on click
    layerA.on Events.Click, ->
        layerA.animate
            properties:
                rotation: layerA.rotation + 90
            curve: "ease"