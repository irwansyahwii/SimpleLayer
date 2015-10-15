FamousPropertySetter = 
    visible:(layer) ->
        propertyValue = layer._properties.visible
        if propertyValue
            layer._element.setProperty("display", "block")
        else
            layer._element.setProperty("display", "none")

    ignoreEvents: (layer) ->
        propertyValue = layer._properties.ignoreEvents
        if propertyValue
            layer._element.setProperty("pointerEvents", "none")
        else
            layer._element.setProperty("pointerEvents", "auto")

    clip:(layer) ->
        propertyValue = layer._properties.clip

        if layer._properties.scrollHorizontal is true or layer._properties.scrollVertical is true
            layer._element.setProperty("overflow", "auto")
        if layer._properties.clip is true
            layer._element.setProperty("overflow", "hidden")
            
        layer._element.setProperty("overflow", "visible")


    # scrollHorizontal: (layer) ->

    # scrollVertical: (layer) ->


    # shadowColor: (layer) ->

    # force2d: (layer) ->

    borderRadius: (layer) ->
        if not _.isNumber(layer._properties.borderRadius)
            layer._element.setProperty("borderRadius", layer._properties.borderRadius)

        else
            layer._element.setProperty("borderRadius", layer._properties.borderRadius)
            
        

    opacity: (layer) ->
        propertyValue = layer._properties.opacity
        # nodeValues = layer._node.getOpacity()
        layer._element.setOpacity(propertyValue)

    index: (layer) ->
        propertyValue = layer._properties.index
        layer._element.setProperty("zIndex", propertyValue)

    color: (layer) ->
        propertyValue = layer._properties.color
        layer._element.setProperty("color", propertyValue)

    width: (layer) ->
        console.log "FamousPropertySetter::width"
        propertyValue = layer._properties.width
        console.log "propertyValue: #{propertyValue}"
        nodeValues = layer._element.getAbsoluteSize()
        if nodeValues?
            layer._element.setAbsoluteSize(propertyValue, nodeValues[1], nodeValues[2])

    height: (layer) ->
        console.log "FamousPropertySetter::height"
        propertyValue = layer._properties.height
        console.log "propertyValue: #{propertyValue}"
        nodeValues = layer._element.getAbsoluteSize() 
        if nodeValues?
            layer._element.setAbsoluteSize(nodeValues[0], propertyValue, nodeValues[2])


    originX: (layer) ->
        console.log "FamousPropertySetter::originX"
        propertyValue = layer._properties.originX
        console.log "propertyValue: #{propertyValue}"
        originValues = layer._element.getOrigin() 

        console.log "originValues:"
        console.log originValues

        layer._element.setOrigin(propertyValue, originValues[1], originValues[2])

    originY: (layer) ->
        propertyValue = layer._properties.originY

        originValues = layer._element.getOrigin()

        console.log "originValues:"
        console.log originValues

        layer._element.setOrigin(originValues[0], propertyValue, originValues[2])

    x: (layer) ->
        console.log "FamousPropertySetter::x"
        propertyValue = layer._properties.x
        nodeValues = layer._element.getPosition()
        console.log "nodeValues:"
        console.log nodeValues
        console.log "propertyValue: #{propertyValue}"
        # layer._element.setPosition(propertyValue, nodeValues[1], nodeValues[2])
        layer._element.setPosition(propertyValue, layer._properties.y, layer._properties.z)
    y: (layer) ->
        console.log "FamousPropertySetter::y"
        propertyValue = layer._properties.y
        nodeValues = layer._element.getPosition()
        console.log "nodeValues:"
        console.log nodeValues
        console.log "propertyValue: #{propertyValue}"
        # layer._element.setPosition(nodeValues[0], propertyValue, nodeValues[2])
        layer._element.setPosition(layer._properties.x, propertyValue, layer._properties.z)

    z: (layer) ->
        console.log "FamousPropertySetter::z"
        propertyValue = layer._properties.z
        nodeValues = layer._element.getPosition()
        console.log "nodeValues:"
        console.log nodeValues
        console.log "propertyValue: #{propertyValue}"
        # layer._element.setPosition(nodeValues[0], nodeValues[1], propertyValue)
        layer._element.setPosition(layer._properties.x, layer._properties.y, propertyValue)

    scale: (layer) ->        
        console.log "FamousPropertySetter::scale"
        propertyValue = layer._properties.scale

        nodeValues = layer._element.getScale()
        layer._element.setScale(propertyValue, propertyValue, propertyValue)
        

    rotationX: (layer) ->
        console.log "FamousPropertySetter::rotationX"
        # propertyValue = (layer._properties.rotationX * Math.PI/180)
        propertyValue = (layer._properties.rotationX )
        nodeValues = layer._element.getRotation()
        layer._element.setRotation(propertyValue, nodeValues[1], nodeValues[2])

    rotationY: (layer) ->
        console.log "FamousPropertySetter::rotationY"
        # propertyValue = (layer._properties.rotationY * Math.PI/180)
        propertyValue = (layer._properties.rotationY)
        nodeValues = layer._element.getRotation()
        layer._element.setRotation(nodeValues[0], propertyValue, nodeValues[2])

    rotationZ: (layer) ->
        console.log "FamousPropertySetter::rotationZ"
        propertyValue = (layer._properties.rotationZ * Math.PI/180)
        nodeValues = layer._element.getRotation()
        layer._element.setRotation(nodeValues[0], nodeValues[1], propertyValue)


    backgroundColor: (layer) ->
        propertyValue = layer._properties.backgroundColor
        
        layer._element.setProperty("backgroundColor",  propertyValue)

module.exports = FamousPropertySetter