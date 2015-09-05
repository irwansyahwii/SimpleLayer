famous = require("famous")

FamousWindow = require("./FamousWindow")
Application = require("./Application")

LayerId = require("./LayerId")

Logger = require('./Logger')

DOMElement = famous.domRenderables.DOMElement


class Layer
    constructor:(options) ->

        Logger.log "Layer constructor called..."

        @_id = LayerId.generateNewId()
        @_name = ""
        @_x = options.x || 0
        @_y = options.y || 0
        @_width = options.width || 0
        @_height = options.height || 0
        @_window = options.window
        if not @_window?
            @_window = Application.getRootWindow()
        @_tagName = "div"        
        @_xAxisSizeMode = "absolute"
        @_yAxisSizeMode = "absolute"
        @_zAxisSizeMode = "absolute"
        @_scale = options.scale || 1
        # @_borderRadius = options.borderRadius || 0
        @_backgroundColor = options.backgroundColor || '#FFFFFF'

        @_layerNode = @_window.createNode()
        @_layerElement = new DOMElement(@_layerNode,
                tagName: @_tagName
                properties:
                    backgroundColor: @_backgroundColor
            )

        @_borderRadius = options.borderRadius || 0        
        if @_borderRadius > 0
            @applyBorderRadius()

        @_scale = options.scale || 1
        @_opacity = options.opacity || 1.0
        @_rotation = options.rotation || 0
        @_superlayer = options.superlayer || null


        Application.init()

        @_layerNode.setScale(@_scale, @_scale)

        if @_x isnt 0 or @_y isnt 0
            @applyPosition()

        if @_scale isnt 1
            @applyScale()
        if @_opacity isnt 1.0
            @applyOpacity()

        if @_rotation isnt 0
            @applyRotation()

        @_layerNode.setSizeMode(@_xAxisSizeMode, @_yAxisSizeMode, @_zAxisSizeMode)
        @_layerNode.setAbsoluteSize(@_width, @_height)

        @_layerNode.setOrigin(0.5, 0.5)

            

    applyBorderRadius:() =>
        
        @_layerElement.setProperty('border-radius', "#{@_borderRadius}px")
        @_layerElement.setProperty('border', "#{@_borderRadius}px solid #{@_backgroundColor}")        

    @property 'borderRadius',
        get: ->
            @_borderRadius

        set: (newVal) ->
            if @_borderRadius isnt newVal   
                @_borderRadius = newVal             
                @applyBorderRadius()

    @property 'id',
        get: ->
            @_id

    @property 'name',
        get: ->
            @_name
        set: (newVal) ->
            @_name = newVal

    applyPosition: =>
        @_layerNode.setPosition(@_x, @_y)            

    @property 'x',
        get: ->
            @_x

        set: (newVal) ->
            if @_x isnt newVal                
                poolContext = =>                        
                    context = @_layerNode.getParent().getUpdater().compositor.getContext('body')

                    if context?
                        @_x = newVal
                        @applyPosition()
                        
                    else
                        setTimeout =>
                                poolContext()
                            , 1

                        

                poolContext()        


    @property 'y',
        get: ->
            @_y

        set: (newVal) ->
            if @_y isnt newVal
                poolContext = =>                        
                    context = @_layerNode.getParent().getUpdater().compositor.getContext('body')

                    if context?
                        @_y = newVal
                        @applyPosition()
                        
                    else
                        setTimeout =>
                                poolContext()
                            , 1

                        

                poolContext()        

    applyScale: =>
        @_layerNode.setScale(@_scale, @_scale, @_scale)

    @property 'scale',
        get: ->
            @_scale

        set: (newVal) ->
            if @_scale isnt newVal
                @_scale = newVal
                @applyScale()

    applyOpacity: () =>
        @_layerNode.setOpacity(@_opacity)

    @property 'opacity', 
        get: ->
            @_opacity

        set: (newVal)->
            if @_opacity isnt newVal
                @_opacity = newVal
                @applyOpacity()


    applyRotation: () =>
        thetaRadian = 2 * Math.PI / (360)
        @_layerNode.setRotation(0, 0, @_rotation * thetaRadian)

    @property 'rotation',
        get: ->
            @_rotation
        set: (newVal)->
            if @_rotation isnt newVal
                @_rotation = newVal
                @applyRotation()


    centerAxis: (isX, isY) =>
        poolSize = =>                        
            context = @_layerNode.getParent().getUpdater().compositor.getContext('body')
            if context?
                if @_superlayer isnt null
                    parentSize = @_superlayer.getSize()
                    

                    if isX
                        @x = (parentSize[0]/2) - (@_layerNode.getAbsoluteSize()[0]/2)

                    if isY
                        @y = (parentSize[1]/2) - (@_layerNode.getAbsoluteSize()[1]/2)

                else
                    contextSize = context._size

                    if isX
                        @x = (contextSize[0] / 2) - (@_layerNode.getAbsoluteSize()[0]/2)

                    if isY
                        @y = (contextSize[1] / 2) - (@_layerNode.getAbsoluteSize()[1]/2)

            else
                setTimeout =>
                        poolSize()
                    , 1

                

        poolSize()


    centerX: () =>        

        @centerAxis(true, false)

    centerY: () =>                
        @centerAxis(false, true)

    center: () =>        
        @centerAxis(true, true)        

    getSize: () =>
        @_layerNode.getAbsoluteSize()

    applySuperlayer: () =>


    @property 'superlayer',
        get: ->
            @_superlayer
        set: (newVal) ->
            if @_superlayer isnt newVal
                @_superlayer = newVal
                @applySuperlayer()


module.exports = Layer