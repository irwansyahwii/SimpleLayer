Logger  = require('./Logger')
Layer = require("./Layer")
Application = require('./Application')

Application.run ->    
    layerA = new Layer
        width: 80
        height: 80
        backgroundColor: "green"

    layerA.borderRadius = 5

    layerA.x = 10
    layerA.y = 10

    # layerA.scale = 0.5
    layerA.opacity = 0.3

    layerA.rotation = 45


    layerB = new Layer
        width: 60
        height: 60
        backgroundColor: "#2DD7AA"
        scale: 1
        borderRadius: 3



    layerB.superlayer = layerA

    # layerB.rotation = 45
    # layerB.centerX()

    # layerB.y = 10
    # layerB.x = 10
    Logger.log "layerB.x: #{layerB.x}"


    # layerB.opacity = 0.8
