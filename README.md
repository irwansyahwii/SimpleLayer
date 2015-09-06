# SimpleLayer
An animation framework based on Framer API but being built on top of Famous

# How to use

``` javascript
Layer = require("./Layer")
BackgroundLayer = require("./BackgroundLayer")
Application = require('./Application')

#
# Just put your existing Framer's code inside 
# Application.run() and it will works :)
#
Application.run ->    

    bg = new BackgroundLayer
        backgroundColor: "#877DD7"

    layerA = new Layer
        width: 150
        height: 150
        backgroundColor: "#fff"
        borderRadius: 6

    layerB = new Layer
        width: 150
        height: 150
        backgroundColor: "#fff"
        borderRadius: 150
        
    layerA.center()
    layerB.center()
    layerA.x -= 90
    layerB.x += 90

    layerA.animate 
        properties:
            rotation: 90
        curve: "ease"


    layerB.animate 
        properties:
            rotation: 90
            borderRadius: 6
        curve: "spring(200,30,0)"
        delay: 1
```
