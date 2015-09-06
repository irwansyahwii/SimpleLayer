Logger  = require('./Logger')
Layer = require("./Layer")
Application = require('./Application')

Application.run ->    
    layerA = new Layer
        width: 260
        height: 260
        backgroundColor: "green"


    # layerA.borderRadius = 5
    # layerA.x = 300
    # layerA.y = 200

    layerB = new Layer
        width: 60
        height: 60
        backgroundColor: "#2DD7AA"
        scale: 1
        borderRadius: 3



    layerB.superlayer = layerA

    # layerB.rotation = 45
    layerB.centerX()

    # layerB.y = 10
    # layerB.x = 10
    Logger.log "layerB.x: #{layerB.x}"


    # layerB.opacity = 0.8
