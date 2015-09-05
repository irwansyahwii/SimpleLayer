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

        @_borderRadius = 0
        borderRadius = options.borderRadius || 0
        if borderRadius > 0
            @applyBorderRadius(borderRadius)


        Application.init()

        @_layerNode.setScale(@_scale, @_scale)

        @applyPosition()

        @_layerNode.setSizeMode(@_xAxisSizeMode, @_yAxisSizeMode, @_zAxisSizeMode)
        @_layerNode.setAbsoluteSize(@_width, @_height)


    applyBorderRadius:(newVal) =>
        
        @_layerElement.setProperty('border-radius', "#{@_borderRadius}px")
        @_layerElement.setProperty('border', "2px solid #{@_backgroundColor}")        

    @property 'borderRadius',
        get: ->
            @_borderRadius

        set: (newVal) ->
            if @_borderRadius isnt newVal   
                @_borderRadius = newVal             
                @applyBorderRadius(newVal)

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
                @_x = newVal
                @applyPosition()

    @property 'y',
        get: ->
            @_y

        set: (newVal) ->
            if @_y isnt newVal
                @_y = newVal
                @applyPosition()


module.exports = Layer