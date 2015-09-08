Logger  = require('./Logger')
Layer = require("./Layer")
BackgroundLayer = require("./BackgroundLayer")
Application = require('./Application')
Events = require('./Events')

Clock = require("./Clock")

Application.run ->    

    # Set background
    bg = new BackgroundLayer backgroundColor: "#000000"
    bg.bringToFront()

    # Create layer
    layerA = new Layer
        image: './images/famous-logo.svg'
        backgroundColor: "transparent"
        width: 250
        height: 250
        
    layerA.center()

    # layerA.animate 
    #     properties:
    #         rotationY: Clock.getTime()/1000
        
    # Rotate on click
    i = 0
    layerA.on Events.Click, ->

        # layerA.rotationY = 160
        # Logger.log "layerA.rotationY: #{layerA.rotationY}"

        doAnim = ->
            Logger.log "existing layerA.rotationY: #{Math.abs(layerA.rotationY)}, plus 20: #{Math.abs(layerA.rotationY) + 20}"

            
            layerA.animate
                properties:
                    rotationY: layerA.rotationY + 20

            setTimeout ->
                    doAnim()
                , 500

        doAnim()