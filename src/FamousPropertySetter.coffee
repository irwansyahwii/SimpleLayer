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
        layer._node.setOpacity(propertyValue)

    index: (layer) ->
        propertyValue = layer._properties.index
        layer._element.setProperty("zIndex", propertyValue)

    color: (layer) ->
        propertyValue = layer._properties.color
        layer._element.setProperty("color", propertyValue)

    width: (layer) ->
        propertyValue = layer._properties.width
        nodeValues = layer._node.getAbsoluteSize()
        layer._node.setAbsoluteSize(propertyValue, nodeValues[1], nodeValues[2])

    height: (layer) ->
        propertyValue = layer._properties.height
        nodeValues = layer._node.getAbsoluteSize()
        layer._node.setAbsoluteSize(nodeValues[0], propertyValue, nodeValues[2])


    originX: (layer) ->
        propertyValue = layer._properties.originX

        originValues = layer._node.getOrigin()

        layer._node.setOrigin(propertyValue, originValues[1], originValues[2])

    originY: (layer) ->
        propertyValue = layer._properties.originY

        originValues = layer._node.getOrigin()

        layer._node.setOrigin(originValues[0], propertyValue, originValues[2])

    x: (layer) ->
        propertyValue = layer._properties.x
        nodeValues = layer._node.getPosition()
        layer._node.setPosition(propertyValue, nodeValues[1], nodeValues[2])
    y: (layer) ->
        propertyValue = layer._properties.y
        nodeValues = layer._node.getPosition()
        layer._node.setPosition(nodeValues[0], propertyValue, nodeValues[2])

    z: (layer) ->
        propertyValue = layer._properties.z
        nodeValues = layer._node.getPosition()
        layer._node.setPosition(nodeValues[0], nodeValues[1], propertyValue)

    scale: (layer) ->        
        propertyValue = layer._properties.scale

        nodeValues = layer._node.getScale()
        layer._node.setScale(propertyValue, propertyValue, propertyValue)
        

    rotationX: (layer) ->
        propertyValue = (layer._properties.rotationX * Math.PI/180)
        nodeValues = layer._node.getRotation()
        layer._node.setRotation(propertyValue, nodeValues[1], nodeValues[2])

    rotationY: (layer) ->
        propertyValue = (layer._properties.rotationY * Math.PI/180)
        nodeValues = layer._node.getRotation()
        layer._node.setRotation(nodeValues[0], propertyValue, nodeValues[2])

    rotationZ: (layer) ->
        propertyValue = (layer._properties.rotationZ * Math.PI/180)
        nodeValues = layer._node.getRotation()
        layer._node.setRotation(nodeValues[0], nodeValues[1], propertyValue)


    backgroundColor: (layer) ->
        propertyValue = layer._properties.backgroundColor
        
        layer._element.setProperty("background-color",  propertyValue)

module.exports = FamousPropertySetter