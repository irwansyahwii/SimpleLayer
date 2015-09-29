class FamousLayer
    constructor: (options) ->

        defaultProp = 
            backgroundColor: '#FA5C4F'
            overflow: "auto"

        options = options || defaultProp

        @surface = new ContainerSurface
            properties: options

        @stateModifier = new StateModifier
            size: [200, 200]
            origin: [0.5, 0.5]

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
        @surface.setContent(contentVal)

    setId:(idValue) =>
        @_id = idValue

    setAttribute: (attrName, attrValue) =>
        @surface.setAttributes(
                attrName: attrValue
            )

    setProperty: (propName, propValue) =>
        @surface.setProperties(
                propName: propValue
            )


    removeFromParent: () =>
        if @superLayer?
            @superLayer.removeSubLayer(@)

    removeChild:(child) =>
        @removeSubLayer(child)

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
        @stateModifier.setSize([val, currentSize[1]])

    setHeight:(val) =>
        currentSize = @stateModifier.getSize()
        @stateModifier.setSize([currentSize[0], val])

module.exports = FamousLayer