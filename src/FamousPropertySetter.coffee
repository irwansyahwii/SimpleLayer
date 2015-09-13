FamousPropertySetter = 
    width: (layer) ->
        propertyValue = layer._properties.width
        nodeValues = layer._node.getAbsoluteSize()
        console.log(nodeValues)
        layer._node.setAbsoluteSize(propertyValue, nodeValues[1], nodeValues[2])
        console.log(nodeValues)

    height: (layer) ->
        propertyValue = layer._properties.height
        nodeValues = layer._node.getAbsoluteSize()
        console.log(nodeValues)
        layer._node.setAbsoluteSize(nodeValues[0], propertyValue, nodeValues[2])
        console.log(nodeValues)

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

        originValues = layer._node.getOrigin()
        layer._node.setOrigin(0.5, 0.5)

        nodeValues = layer._node.getScale()
        layer._node.setScale(propertyValue, propertyValue, propertyValue)
        
        layer._node.setOrigin(originValues[0], originValues[1], originValues[2])

    rotationZ: (layer) ->
        propertyValue = (layer._properties.rotationZ * Math.PI/180)
        nodeValues = layer._node.getRotation()
        layer._node.setRotation(0, 0, propertyValue)


    backgroundColor: (layer) ->
        propertyValue = layer._properties.backgroundColor
        
        layer._element.setProperty("background-color", propertyValue)

module.exports = FamousPropertySetter