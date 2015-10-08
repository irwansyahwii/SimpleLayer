famous = require("famous")

ContainerSurface = famous.surfaces.ContainerSurface
StateModifier = famous.modifiers.StateModifier
RenderNode = famous.core.RenderNode
Transform = famous.core.Transform

class FamousLayer
    constructor: (options) ->

        defaultProp = {}

        options = options || defaultProp

        @surface = new ContainerSurface
            properties: options

        @stateModifier = new StateModifier(
                origin:[0.5, 0.5]
                transform: Transform.translate()
            )

        @node = new RenderNode(@stateModifier)
        @node.add(@surface)

        @_id = null

        @_attributes = @surface.attributes
        @_styles = @surface.properties
        @classList = @surface.classList
        @_content = @surface.content

        @parentNode = null

        # mainContext.add(@node)        

    setContent: (contentVal) =>
        console.log "@surface.setContent()"
        @surface.setContent(contentVal)

    setId:(idValue) =>
        @_id = idValue

    setAttribute: (attrName, attrValue) =>
        console.log "@surface.setAttribute()"
        @surface.setAttributes(
                attrName: attrValue
            )

    setProperty: (propName, propValue) =>
        console.log "@surface.setProperty(#{propName}, #{propValue})"
        @surface.setProperties(
                "#{propName}": propValue
            )


    removeFromParent: () =>

        if @superLayer?
            @superLayer.removeSubLayer(@)

    removeChild:(child) =>
        @removeSubLayer(child)

    setOpacity:(opacityValue) =>
        console.log "@stateModifier.setOpacity(#{opacityValue})"
        @stateModifier.setOpacity(opacityValue)

    getAbsoluteSize: () =>        
        currentSize = @stateModifier.getSize()
        console.log "currentSize:"
        console.log currentSize

        (currentSize || [0, 0, 0])

    setAbsoluteSize: (x, y, z) =>
        console.log "@stateModifier.setSize([#{x}, #{y}, #{z}])"
        @stateModifier.setSize([x, y, z])


    getOrigin: () =>
        (@stateModifier.getOrigin() || [0, 0, 0])

    setOrigin: (x, y, z) =>
        console.log "@stateModifier.setOrigin(#{x}, #{y}, #{z})"


        z = z || 0
        @stateModifier.setOrigin([x, y, z])


    getPosition: () =>
        currentPos = Transform.getTranslate(@stateModifier.getTransform())

        currentPos[0] = currentPos[0] || 0
        currentPos[1] = currentPos[1] || 0
        currentPos[2] = currentPos[2] || 0

        currentPos

    setPosition2: (x, y, z) =>
        @stateModifier.setTransform(Transform.translate(x, y, z))

    setPosition: (x, y, z) =>
        
        console.log "FamousLayer::setPosition: x: #{x}, y: #{y}, z: #{z}"
        # @stateModifier.setTransform(Transform.translate(x, y, z))

        # @stateModifier.setTransform(Transform.translate(800, 300, 0))

        # currentTransform =  Transform.getTranslate(@stateModifier.getTransform())
        # console.log "currentTransform:"
        # console.log currentTransform

        # @stateModifier.setTransform(Transform.translate(x, currentTransform[1] || 0, currentTransform[2] || 0))

        currentTransform =  Transform.getTranslate(@stateModifier.getTransform())
        console.log "position before:"
        console.log currentTransform

        @stateModifier.setTransform(Transform.translate(x, y, z))


        currentTransform =  Transform.getTranslate(@stateModifier.getTransform())
        console.log "position after:"
        console.log currentTransform

    getScale: () =>
        Transform.interpret(@stateModifier.getTransform()).scale

    setScale: (x, y, z) =>

        currentTransform =  Transform.getTranslate(@stateModifier.getTransform())
        console.log "position before:"
        console.log currentTransform

        console.log "@stateModifier.setTransform(Transform.scale(#{x}, #{y}, #{z}))"
        # @stateModifier.setTransform(Transform.scale(x, y, z))

        currentTransform =  Transform.getTranslate(@stateModifier.getTransform())
        console.log "position after:"
        console.log currentTransform

    getRotation: () =>
        Transform.interpret(@stateModifier.getTransform()).rotate


    setRotation: (x, y, z) =>
        console.log "@stateModifier.setTransform(Transform.rotate(#{x}, #{y}, #{z}))"
        # @stateModifier.setTransform(Transform.rotate(x, y, z))



    removeSubLayer:(layer) =>

        if not (@surface.context._node._child instanceof Array)
            @surface.context._node._child = null
        else
            removeIndex = @surface.context._node._child.indexOf(layer.node)
            @surface.context._node._child.splice(removeIndex, 1)        


        layer.superLayer = null
        layer.parentNode = null

    addSubLayer: (layer) =>
        if layer.superLayer?
            layer.superLayer.removeSubLayer(layer)

        @surface.add(layer.node)
        layer.superLayer = @
        layer.parentNode = @

    setX: (val) =>
        currentTransform =  Transform.getTranslate(@stateModifier.getTransform())
        console.log "setX. currentTransform: #{currentTransform}"
        console.log currentTransform
        @stateModifier.setTransform(Transform.translate(val, currentTransform[1], currentTransform[2]))

    setY: (val) =>
        currentTransform = Transform.getTranslate(@stateModifier.getTransform())
        console.log "setY. currentTransform: #{currentTransform}"
        console.log currentTransform
        @stateModifier.setTransform(Transform.translate(currentTransform[0], val, currentTransform[2]))


    setWidth:(val) =>        
        currentSize = @stateModifier.getSize()        

        console.log "@stateModifier.setSize([#{val}, currentSize[1]])"
        @stateModifier.setSize([val, currentSize[1]])

    setHeight:(val) =>
        
        currentSize = @stateModifier.getSize()

        console.log "@stateModifier.setSize([currentSize[0], #{val}])"
        @stateModifier.setSize([currentSize[0], val])

module.exports = FamousLayer