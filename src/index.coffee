Logger  = require('./Logger')
Layer = require("./Layer")
BackgroundLayer = require("./BackgroundLayer")
Application = require('./Application')
Events = require('./Events')

Application.run ->    

    # Create layer, define image
    layerA = new Layer
        width: 400
        height: 400
        image: "http://cl.ly/arBO/bg.jpg"
        borderRadius: 4
        
    layerA.center()