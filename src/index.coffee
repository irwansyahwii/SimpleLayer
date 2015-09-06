Logger  = require('./Logger')
Layer = require("./Layer")
BackgroundLayer = require("./BackgroundLayer")
Application = require('./Application')
Events = require('./Events')

Application.run ->    



    # Create layer
    layerA = new Layer
        x: 100
        y: 100
        width: 200
        height: 200
        borderRadius: 8
        backgroundColor: "#28affa"