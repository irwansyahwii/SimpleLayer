

famous = require("famous")

FamousWindow = require("./FamousWindow")
Application = require("./Application")

LayerId = require("./LayerId")

Logger = require('./Logger')

DOMElement = famous.domRenderables.DOMElement

Rotation = famous.components.Rotation

Position = famous.components.Position

Transitionable = famous.transitions.Transitionable

Events = require("./Events")

Quaternion = famous.math.Quaternion


_ = require('./Underscore')


class Layer


    constructor:(options) ->
        @_id = LayerId.generateNewId()
        @_name = ""
        @_window = options.window
        if not @_window?
            @_window = Application.getRootWindow()

        @_layerNode = @_window.createNode()        
        @_layerNode.setOrigin(0.5, 0.5, 0.5)

        @_rotationY = 0

        @_tagName = "div"

        @_ignoreEvents = false

        image = options.image || null

        attributes = null

        if image isnt null
            @_tagName = "img"
        

        @_layerElement = new DOMElement(@_layerNode,
                tagName: @_tagName
            )

        if image isnt null
            @_layerElement.setAttribute("src", image)
        

        backgroundColor = options.backgroundColor || null
        if backgroundColor isnt null
            @applyBackgroundColor(backgroundColor)

        
        borderRadius = options.borderRadius || null
        if borderRadius isnt null
            @applyBorderRadius(borderRadius)

        width = options.width || 0
        height = options.height || 0

        if width >= 0
            @_layerNode.setSizeMode("absolute", "absolute", "absolute")
            @applyWidth(width)

        if height >= 0
            @_layerNode.setSizeMode("absolute", "absolute", "absolute")
            @applyHeight(height)

        # @_layerNode.setMountPoint(0.5, 0.5)


        x = options.x || 0
        y = options.y || 0

        @applyX(x)
        @applyY(y)

        @_superlayer = options.superLayer || null
        @applySuperlayer(@_superlayer)

        @eventsHandlers = []

        @_layerNode.addUIEvent(Events.Click)

        @_layerNode.onReceive = (event, payload) =>
            if not @_ignoreEvents            
                handler = @eventsHandlers[event] || null;

                if handler isnt null
                    handler()

        @_layerNode.layer = @
        @_layerElement.layer = @


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

    applyZ: (newVal) =>
        currentPos = @_layerNode.getPosition()
        @_layerNode.setPosition(currentPos[0], currentPos[1], newVal)

    @property 'z',
        get: ->
            currentPos = @_layerNode.getPosition()
            currentPos[2]

        set: (newVal) ->
            if @y isnt newVal                                                
                @applyZ(newVal)

    @property 'point',
        get: ->
            point = 
                x : @x
                y : @y

            point

        set: (newVal) ->
            if @point isnt newVal
                if newVal?
                    if @point.x isnt newVal.x or @point.y isnt newVal.y
                        @x = newVal.x
                        @y = newVal.y


    @property 'size',
        get: ->
            size = 
                width: @width
                height: @height

            size

        set: (newVal) ->
            if @size isnt newVal
                if newVal?
                    if @size.width isnt newVal.width or @size.height isnt newVal.height
                        @width = newVal.width
                        @height = newVal.height

    @property 'frame',
        get: ->
            frame =
                x: @x
                y: @y 
                width: @width
                height: @height

            frame

        set: (newVal) ->
            if @frame isnt newVal
                if newVal?                    
                    @point = newVal
                    @size = newVal

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

    applyScale:(newVal) =>
        @applyScaleX(newVal)
        @applyScaleY(newVal)

    @property 'scale',
        get: ->
            currentScale = @_layerNode.getScale()

            currentScale[0]

        set: (newVal) ->
            if @scale isnt newVal
                @applyScale(newVal)

    applyOpacity: (newVal) =>
        @_layerNode.setOpacity(newVal)

    @property 'opacity', 
        get: ->
            @_layerNode.getOpacity()

        set: (newVal)->
            if @opacity isnt newVal
                @applyOpacity(newVal)


    degreeToRadian: (degree) =>

        result = (degree * Math.PI) / 180.0

        result

    radianToDegree: (radian) =>
        result = radian * 180.0 / Math.PI

        result


    applyRotation: (newVal) =>        
        currentRotation = @_layerNode.getRotation()            
        @_layerNode.setRotation(currentRotation[0], currentRotation[1], @angleToFamousRotation(newVal))



    @property 'rotation',
        get: ->
            currentRotation = @_layerNode.getRotation()            

            q = new Quaternion(currentRotation[3], currentRotation[0], currentRotation[1], currentRotation[2])

            eulerResult = {}

            q.toEuler(eulerResult)

            thetaRadian = Math.PI / (180)

            eulerResult.z / thetaRadian

        set: (newVal)->
            if @rotation isnt newVal
                @applyRotation(newVal)

    applyRotationX: (newVal) =>        
        currentRotation = @_layerNode.getRotation()            
        # @_layerNode.setRotation(@angleToFamousRotation(newVal), currentRotation[1], currentRotation[2])
        @_layerNode.setRotation(@degreeToRadian(newVal), currentRotation[1], currentRotation[2])

    @property 'rotationX',
        get: ->
            currentRotation = @_layerNode.getRotation()            

            q = new Quaternion(currentRotation[3], currentRotation[0], currentRotation[1], currentRotation[2])

            eulerResult = {}

            q.toEuler(eulerResult)

            @radianToDegree(eulerResult.x)

        set: (newVal)->
            if @rotation isnt newVal
                @applyRotationX(newVal)

    applyRotationY: (newVal) =>        

        @_rotationY = newVal

        currentRotation = @_layerNode.getRotation()            
        # @_layerNode.setRotation(@angleToFamousRotation(newVal), currentRotation[1], currentRotation[2])

        # Logger.log "assigning #{@degreeToRadian(newVal)} to rotationY "
        @_layerNode.setRotation(currentRotation[0], @degreeToRadian(newVal), currentRotation[2])

    @property 'rotationY',
        get: ->
            @_rotationY

        set: (newVal)->
            if @rotation isnt newVal
                @applyRotationY(newVal)



    applyRotationZ: (newVal) =>        
        currentRotation = @_layerNode.getRotation()            
        @_layerNode.setRotation(currentRotation[0], currentRotation[1], @angleToFamousRotation(newVal))

    @property 'rotationZ',
        get: ->
            currentRotation = @_layerNode.getRotation()            

            q = new Quaternion(currentRotation[3], currentRotation[0], currentRotation[1], currentRotation[2])

            eulerResult = {}

            q.toEuler(eulerResult)

            thetaRadian = Math.PI / (180)

            eulerResult.z / thetaRadian

        set: (newVal)->
            if @rotation isnt newVal
                @applyRotationZ(newVal)

    @property 'subLayers',
        get: ->
            subLayers = []

            children = @_layerNode.getChildren() || []

            for child in children
                if child.layer?
                    subLayers.push(child.layer)

            subLayers

    applyHtml: (newVal) =>
        @_layerElement.setContent(newVal)
        
    @property 'html',
        get: ->
            values = @_layerElement.getValue()

            values.content

        set: (newVal) ->
            if @html isnt newVal
                @applyHtml(newVal)

    subLayersByName: (name) =>
        subLayers = @subLayers

        result = []

        for subLayer in subLayers
            if subLayer.name?
                if subLayer.name is name
                    result.push(subLayer)

        result

    addSubLayer: (layer) =>
        if layer?
            @_layerNode.addChild(layer._layerNode)

    removeSubLayer: (layer) =>
        if layer? and layer._layerNode?
            @_layerNode.removeChild(layer._layerNode)

    siblingLayers: () =>
        result = []

        parentChildren = @_layerNode.getParent().getChildren()

        for child in parentChildren
            if child.layer?
                result.push(child.layer)

        result

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
        # @centerAxis(true, true)
        @_layerNode.setAlign(0.5, 0.5)
        @_layerNode.setMountPoint(0.5, 0.5)
        @_layerNode.setOrigin(0.5, 0.5)

    _centerUsingAlign: () =>        
        originalMountPoint = @_layerNode.getMountPoint()

        @_layerNode.setMountPoint(0.5, 0.5, originalMountPoint[2])
        @_layerNode.setAlign(0.5, 0.5)

        @_layerNode.setMountPoint(originalMountPoint[0], originalMountPoint[1], originalMountPoint[2])

    getSize: () =>
        @_layerNode.getAbsoluteSize()

    applySuperlayer: (newVal) =>

        if newVal isnt null

            @_layerNode.getParent().removeChild(@_layerNode)

            newVal._layerNode.addChild(@_layerNode)


    @property 'superlayer',
        get: ->
            @_superlayer
        set: (newVal) ->
            if @_superlayer isnt newVal
                @_superlayer = newVal
                @applySuperlayer(newVal)


    applyImage: (imageUrl) =>
        @_layerElement.setProperty('background-image', "url('#{newVal}')")

    @property 'image',
        get: ->
            elementValue = @_layerElement.getValue()
            return elementValue.styles['background-image'] 

        set: (newVal)->
            if @image isnt newVal
                @applyImage(newVal)


    applyVisible: (newVal) =>
        if newVal
            @_layerNode.show()
        else
            @_layerNode.hide()

    @property 'visible',
        get: ->
            @_layerNode.isShown()

        set: (newVal) ->
            if @visible isnt newVal
                @applyVisible(newVal)


    applyClip: (newVal) =>

        @_layerElement.setProperty('overflow', newVal)

    @property 'clip',
        get: ->
            elementValue = @_layerElement.getValue()
            return elementValue.styles['overflow'] 

        set: (newVal) ->
            if @clip isnt newVal
                @applyClip(newVal)

    applyIgnoreEvents: (newVal) =>
        @_ignoreEvents = newVal

    @property 'ignoreEvents',
        get: ->
            @_ignoreEvents

        set: (newVal)->
            if @ignoreEvents isnt newVal
                @applyIgnoreEvents(newVal)

    applyOriginX: (newVal) =>
        currentValues = @_layerNode.getOrigin()

        @_layerNode.setOrigin(newVal, currentValues[1], currentValues[2])

    @property 'originX',
        get: ->
            currentValues = @_layerNode.getOrigin()

            currentValues[0]

        set: (newVal) ->
            if @originX isnt newVal
                @applyOriginX(newVal)

    applyOriginY: (newVal) =>
        currentValues = @_layerNode.getOrigin()

        @_layerNode.setOrigin(currentValues[0], newVal, currentValues[2])

    @property 'originY',
        get: ->
            currentValues = @_layerNode.getOrigin()

            currentValues[1]

        set: (newVal) ->
            if @originY isnt newVal
                @applyOriginY(newVal)

    retrieveCurveValue: (str) =>

        result = 
            name: ""
            args: []


        if _.endsWith str, ")"
            result.name = str.split("(")[0]
            result.args = str.split("(")[1].split(",").map (a) -> _.trim(_.trimRight(a, ")"))
        else
            result.name = str

        return result


    startAnimation: (animOptions) =>
        rotationXValue = animOptions.properties.rotationX || null 
        rotationYValue = animOptions.properties.rotationY || null 
        rotationZValue = animOptions.properties.rotationZ || null 
        rotationValue = animOptions.properties.rotation || null
        borderRadiusValue = animOptions.properties.borderRadius || null
        

        curveMaps =
            "ease": "easeInOut"

        curveValue = animOptions.curve || ''

        curveObject = @retrieveCurveValue(curveValue)

        curveValue = curveObject.name
    

        # Logger.log "rotationXValue: #{rotationXValue}"
        # Logger.log "rotationYValue: #{rotationYValue}"
        # Logger.log "rotationValue: #{rotationValue}"

        if curveValue is "ease"
            curveValue = "easeInOut"

        if rotationXValue isnt null
            rotationComponent = new Rotation(@_layerNode)    

            rotationComponent.setX(@degreeToRadian(rotationXValue), 
                    duration: 1000
                )

        if rotationYValue isnt null

            rotationYTransitionable = new Transitionable(@rotationY)

            rotationYTransitionable.set(rotationYValue, 
                        duration:
                            1000
                    )

            spinner = @_layerNode.addComponent
                onUpdate: (time) =>
                    @rotationY = rotationYTransitionable.get()
                    if rotationYTransitionable.isActive()
                        @_layerNode.requestUpdate(spinner)

            @_layerNode.requestUpdate(spinner)


        if rotationZValue isnt null
            rotationComponent = new Rotation(@_layerNode)    

            rotationComponent.setZ(@degreeToRadian(rotationZValue), 
                    duration: 1000
                )
        if rotationValue isnt null
            rotationComponent = new Rotation(@_layerNode)            

            rotationComponent.setZ( @angleToFamousRotation(rotationValue),
                    {
                        duration: 1000
                        curve: curveValue
                    }
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


    on: (eventType, eventHandler) =>
        @eventsHandlers[eventType] = eventHandler



module.exports = Layer