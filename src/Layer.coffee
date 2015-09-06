famous = require("famous")

FamousWindow = require("./FamousWindow")
Application = require("./Application")

LayerId = require("./LayerId")

Logger = require('./Logger')

DOMElement = famous.domRenderables.DOMElement

Rotation = famous.components.Rotation

Position = famous.components.Position

Transitionable = famous.transitions.Transitionable


class Layer


    constructor:(options) ->
        @_id = LayerId.generateNewId()
        @_name = ""
        @_window = options.window
        @_superlayer = null
        if not @_window?
            @_window = Application.getRootWindow()

        @_layerNode = @_window.createNode()        
        @_layerNode.setOrigin(0.5, 0.5)
        

        @_layerElement = new DOMElement(@_layerNode,
                tagName: @_tagName
            )
        

        backgroundColor = options.backgroundColor || '#FFFFFF'
        @applyBackgroundColor(backgroundColor)

        
        borderRadius = options.borderRadius || 0
        @applyBorderRadius(borderRadius)

        width = options.width || 0
        height = options.height || 0

        if width >= 0
            @_layerNode.setSizeMode("absolute", "absolute", "absolute")
            @applyWidth(width)

        if height >= 0
            @_layerNode.setSizeMode("absolute", "absolute", "absolute")
            @applyHeight(height)


        x = options.x || 0
        y = options.y || 0

        @applyX(x)
        @applyY(y)


    applyHeight: (val) =>
        currentSize = @_layerNode.getAbsoluteSize()


        @_layerNode.setAbsoluteSize(currentSize[0], val, currentSize[2])

    @property 'height',
        get: ->
            currentSize = @_layerNode.getAbsoluteSize()
            currentSize[1]

        set: (newVal) ->
            if @height isnt newVal
                @applyHeight(newVal)

    applyWidth: (val) =>
        currentSize = @_layerNode.getAbsoluteSize()

        @_layerNode.setAbsoluteSize(val, currentSize[1], currentSize[2])

    @property 'width',
        get: ->            
            Logger.log "width property inside"
            currentSize = @_layerNode.getAbsoluteSize()

            Logger.log "width property, currentSize: #{currentSize}"

            currentSize[0]

        set: (newVal) ->
            if @width isnt newVal
                @applyWidth(newVal)

    applyBackgroundColor:(bgColor) =>
        @_layerElement.setProperty("background-color", bgColor)           

    @property 'backgroundColor',
        get: ->
            elementValue = @_layerElement.getValue()
            return elementValue.styles['background-color'] 

        set: (newVal) ->
            if @backgroundColor isnt newVal
                @applyBackgroundColor(newVal)

    applyBorderRadius:(borderRadius) =>
        
        @_layerElement.setProperty('border-radius', "#{borderRadius}px")
        @_layerElement.setProperty('border', "1px solid #{@backgroundColor}")   


    addSubLayer: (subLayer) =>


    @property 'borderRadius',
        get: ->
            elementValue = @_layerElement.getValue()
            strValue = elementValue.styles['borderRadius'] || ''
            if strValue.length > 0
                strValue = strValue.replace("px", "")

                parseInt(strValue, 10)

            else
                0


        set: (newVal) ->
            if @borderRadius isnt newVal
                @applyBorderRadius(newVal)    

    @property 'id',
        get: ->
            @_id

    @property 'name',
        get: ->
            @_name
        set: (newVal) ->
            @_name = newVal

    applyX: (newVal) =>
        currentPos = @_layerNode.getPosition()
        @_layerNode.setPosition(newVal, currentPos[1], currentPos[2])

    @property 'x',
        get: ->
            currentPos = @_layerNode.getPosition()
            currentPos[0]

        set: (newVal) ->
            if @x isnt newVal                                                
                @applyX(newVal)

    applyY: (newVal) =>
        currentPos = @_layerNode.getPosition()
        @_layerNode.setPosition(currentPos[0], newVal, currentPos[2])

    @property 'y',
        get: ->
            currentPos = @_layerNode.getPosition()
            currentPos[1]

        set: (newVal) ->
            if @y isnt newVal                                                
                @applyY(newVal)


    @property 'minX',
        get: ->
            @x

    @property 'maxX',
        get: ->
            @x + @width

    @property 'minY',
        get: ->
            @y

    @property 'maxY',
        get: ->
            @y + @height

    @property 'midX',
        get: ->
            (@minX + @maxX)/2

    @property 'midY',
        get: ->
            (@minY + @maxY)/2

    applyScaleX:(newVal) =>
        currentScale = @_layerNode.getScale()
        @_layerNode.setScale(newVal, currentScale[1], currentScale[2])

    applyScaleY:(newVal) =>
        currentScale = @_layerNode.getScale()
        @_layerNode.setScale(currentScale[0], newVal, currentScale[2])

    applyScaleZ:(newVal) =>
        currentScale = @_layerNode.getScale()
        @_layerNode.setScale(currentScale[0], currentScale[1], newVal)

    @property 'scale',
        get: ->
            currentScale = @_layerNode.getScale()

            currentScale[0]

        set: (newVal) ->
            Logger.log "newVal scale: #{newVal}"
            if @scale isnt newVal
                @applyScaleX(newVal)
                @applyScaleY(newVal)

    applyOpacity: (newVal) =>
        @_layerNode.setOpacity(newVal)

    @property 'opacity', 
        get: ->
            @_layerNode.getOpacity()

        set: (newVal)->
            if @opacity isnt newVal
                @applyOpacity(newVal)


    angleToFamousRotation: (angle) =>
        thetaRadian = 2 * Math.PI / (360)

        angle * thetaRadian

    applyRotation: (newVal) =>        
        @_layerNode.setRotation(0, 0, @angleToFamousRotation(newVal))

    @property 'rotation',
        get: ->
            currentRotation = @_layerNode.getRotation()

            thetaRadian = 2 * Math.PI / (360)
            currentRotation[2]/thetaRadian
        set: (newVal)->
            if @rotation isnt newVal
                @applyRotation(newVal)

    centerAxis: (isX, isY) =>

        nodeParent = @_layerNode.getParent()

        parentSize = nodeParent.getAbsoluteSize()

        parentClassName = nodeParent.constructor.name

        if parentClassName is 'Scene'
            parentSize = nodeParent.getUpdater().compositor.getContext('body')._size        

        if isX
            @x = (parentSize[0] / 2) - (@width/2)

        if isY
            @y = (parentSize[1] / 2) - (@height/2)

    centerX: () =>        

        @centerAxis(true, false)

    centerY: () =>                
        @centerAxis(false, true)

    center: () =>
        @centerAxis(true, true)

    _centerUsingAlign: () =>        
        originalMountPoint = @_layerNode.getMountPoint()

        @_layerNode.setMountPoint(0.5, 0.5, originalMountPoint[2])
        @_layerNode.setAlign(0.5, 0.5)

        @_layerNode.setMountPoint(originalMountPoint[0], originalMountPoint[1], originalMountPoint[2])

    getSize: () =>
        @_layerNode.getAbsoluteSize()

    applySuperlayer: (newVal) =>

        @_layerNode.getParent().removeChild(@_layerNode)

        newVal._layerNode.addChild(@_layerNode)


    @property 'superlayer',
        get: ->
            @_superlayer
        set: (newVal) ->
            if @_superlayer isnt newVal
                @_superlayer = newVal
                @applySuperlayer(newVal)


    startAnimation: (animOptions) =>
        rotationValue = animOptions.properties.rotation || null
        borderRadiusValue = animOptions.properties.borderRadius || null
        

        curveMaps =
            "ease": "easeInOut"

        curveValue = animOptions.curve || null

        if curveValue is "ease"
            curveValue = "easeInOut"

        if rotationValue isnt null
            rotationComponent = new Rotation(@_layerNode)            

            rotationComponent.set(0, 0, @angleToFamousRotation(rotationValue),
                    duration: 1000
                    curve: curveValue
                )

            @_layerNode.addComponent(rotationComponent)


        if borderRadiusValue isnt null

            Logger.log "borderRadius: #{@borderRadius}, borderRadiusValue: #{borderRadiusValue}"

            borderRadiusTransition = new Transitionable(@borderRadius)
            # borderRadiusTransition.from(@borderRadius).to(borderRadiusValue).delay(delayValue)
            borderRadiusTransition.set(borderRadiusValue, 
                    duration: 1000
                )

            componentId =  @_layerNode.addComponent(
                    onUpdate: (time) =>
                        @borderRadius = borderRadiusTransition.get()
                        if borderRadiusTransition.isActive()
                            @_layerNode.requestUpdate(componentId)
                )
            @_layerNode.requestUpdate(componentId)

    animate: (options) =>
        animOptions = options || {}
        animOptions.properties = animOptions.properties || {}

        delayValue = animOptions.delay || 0
        delayValue = delayValue * 1000

        setTimeout =>
                @startAnimation(animOptions)
            , delayValue





module.exports = Layer