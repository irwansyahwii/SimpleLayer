# require("./Framer")


# containerLayer = new Layer
#     width: Screen.width
#     height: Screen.height
#     backgroundColor: "white"

# l = new Layer
#     width: 67
#     height: 67
#     image: "http://www.kirupa.com/images/smiley_red.png"
#     backgroundColor: "brown"

# l.center()


  
# containerLayer.on Events.Click, (e)->
    
#     l.animate
#         properties:
#             midX: e.clientX
#             midY: e.clientY




  

Engine = require("famous/core/Engine")
Surface = require("famous/core/Surface")
RenderNode = require("famous/core/RenderNode")
ContainerSurface = require("famous/surfaces/ContainerSurface")

Transform = require("famous/core/Transform")
StateModifier = require("famous/modifiers/StateModifier")
Easing = require("famous/transitions/Easing")
RenderController = require("famous/views/RenderController")


# RenderNode.prototype.removeChild = (nodes) ->
#     parent = @
#     children = @_child

#     console.log "BEFORE @_child contents:"
#     console.log(@_child)

#     postrender = ->        
#         if not (nodes instanceof Array)
#             nodes = [nodes]

#         nodes.forEach((node) =>

#             if @_child instanceof Array
#                 removeIndex = @_child.indexOf(node)

#                 @_child.splice(removeIndex, 1)
#             else
#                 @_child = null
#         )

#         console.log "AFTER @_child contents:"
#         console.log(@_child)

#         Engine.removeListener('postrender', postrender)


#     Engine.on('postrender', postrender)
  


mainContext = Engine.createContext()


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
            origin: [0, 0]

        @node = new RenderNode(@stateModifier)
        @node.add(@surface)

        # mainContext.add(@node)        


    removeSubLayer:(layer) =>

        if not (@surface.context._node._child instanceof Array)
            @surface.context._node._child = null
        else
            console.log "child2:"
            console.log @surface.context._node._child

            removeIndex = @surface.context._node._child.indexOf(layer.node)
            @surface.context._node._child.splice(removeIndex, 1)        


        layer.superLayer = null

    addSubLayer: (layer) =>
        if layer.superLayer?
            console.log layer.superLayer
            layer.superLayer.removeSubLayer(layer)

        @surface.add(layer.node)
        layer.superLayer = @

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

layer1 = new FamousLayer
    backgroundColor: 'red'

layer2 = new FamousLayer
    backgroundColor: 'green'


mainContext.add(layer2.node)

layer1.setWidth(100)
layer1.setHeight(100)
layer1.setX(0)

layer2.setX(300)

# mainContext.add(layer1.node)

layer2.addSubLayer(layer1)

layer3 = new FamousLayer
    backgroundColor: "blue"

layer3.setX(700)

mainContext.add(layer3.node)

layer3.addSubLayer(layer1)


layer4 = new FamousLayer
    backgroundColor: "yellow"

layer4.setX(1000)
mainContext.add(layer4.node)


layer4.addSubLayer(layer1)

layer2.addSubLayer(layer1)


# surface = new ContainerSurface
#     properties:
#         backgroundColor: '#FA5C4F'
#         overflow: "auto"
        

# stateModifier = new StateModifier
#     size: [200, 200]
#     origin: [0, 0]
    
# firstSurface = new ContainerSurface({
#   content: 'hello world',
#   properties: {
#     color: 'white',
#     textAlign: 'center',
#     backgroundColor: 'green'
#   }
# })

# mainContext.add(stateModifier).add(surface)


# stateModifierLayer2 = new StateModifier
#     size: [100, 100]
#     origin: [0, 0]


# stateModifierLayer2.setTransform(Transform.translate(0, 150, 0))


# layer2 = surface.add(stateModifierLayer2)
# layer2.add(firstSurface)

# stateModifier.setTransform(Transform.translate(100, 50, 0))


# layer3 = new ContainerSurface
#     properties:
#         backgroundColor: 'brown'
#         overflow: "auto"

# layer3Modifier = new StateModifier
#     size: [200, 200]
#     origin: [0, 0]

# mainContext.add(layer3Modifier).add(layer3)

# layer3Modifier.setTransform(Transform.translate(350, 10, 0))

# stateModifierLayer2.setTransform(Transform.identity)
# stateModifierLayer2.setSize([0, 0])
# stateModifierLayer2.setOrigin(null)
# stateModifierLayer2.setAlign(null)

# layer3.add(firstSurface)



# stateModifier.setTransform(
#     Transform.scale(1, 1, 1),
#     { duration : 2000, curve: Easing.outBack }
# );
