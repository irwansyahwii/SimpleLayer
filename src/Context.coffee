Utils = require "./Utils"

{_} = require "./Underscore"
{BaseClass} = require "./BaseClass"
{Config} = require "./Config"
{EventManager} = require "./EventManager"

Counter = 1

famous = require("famous")
Engine = famous.core.FamousEngine
Node = famous.core.Node
DOMElement = famous.domRenderables.DOMElement

class exports.Context extends BaseClass
	
	constructor: (options={}) ->
		
		super

		Counter++

		options = _.defaults options,
			contextName: null
			parentLayer: null
			name: null

		if not options.name
			throw Error("Contexts need a name")

		@_parentLayer = options.parentLayer
		@_name = options.name
		
		@reset()

	_framerOriginal_reset: ->

		@eventManager?.reset()
		@eventManager = new EventManager

		if @_rootElement
			# Clean up the current root element:
			if @_rootElement.parentNode
				# Already attached to the DOM - remove it:
				@_rootElement.parentNode.removeChild(@_rootElement)
			else
				# Not on the DOM yet. Prevent it from being added (for this happens
				# async):
				@_rootElement.__cancelAppendChild = true

		# Create a fresh root element:
		@_createRootElement()

		@_delayTimers?.map (timer) -> window.clearTimeout(timer)
		@_delayIntervals?.map (timer) -> window.clearInterval(timer)

		if @_animationList
			for animation in @_animationList
				animation.stop(false)

		@_layerList = []
		@_animationList = []
		@_delayTimers = []
		@_delayIntervals = []
		@_layerIdCounter = 1

		@emit("reset", @)

	reset: ->
		@eventManager?.reset()
		@eventManager = new EventManager

		if @_rootElement
			# Clean up the current root element:
			if @_rootElement._node.isMounted()
				# Already attached to the DOM - remove it:
				@_rootElement._node.dismount()
			else
				# Not on the DOM yet. Prevent it from being added (for this happens
				# async):
				@_rootElement.__cancelAppendChild = true

		# Create a fresh root element:
		@_createRootElement()

		@_delayTimers?.map (timer) -> window.clearTimeout(timer)
		@_delayIntervals?.map (timer) -> window.clearInterval(timer)

		if @_animationList
			for animation in @_animationList
				animation.stop(false)

		@_layerList = []
		@_animationList = []
		@_delayTimers = []
		@_delayIntervals = []
		@_layerIdCounter = 1

		@emit("reset", @)
	destroy: ->
		@reset()
		if @_rootElement._node.isMounted()
			@_rootElement._node.dismount()
		Utils.domCompleteCancel(@_appendRootElement)

	getRootElement: ->
		@_rootElement

	getLayers: ->
		_.clone(@_layerList)

	addLayer: (layer) ->
		return if layer in @_layerList
		@_layerList.push(layer)
		return null

	removeLayer: (layer) ->
		@_layerList = _.without(@_layerList, layer)
		return null

	layerCount: ->
		return @_layerList.length

	nextLayerId: ->
		@_layerIdCounter++

	_framerOriginal__createRootElement: ->

		@_rootElement = document.createElement("div")
		@_rootElement.id = "FramerContextRoot-#{@_name}"
		@_rootElement.classList.add("framerContext")

		if @_parentLayer
			@_appendRootElement()
		else
			Utils.domComplete(@_appendRootElement)

	_createRootElement: ->
		console.log("=== Context ===== ")

		console.log("Assiging new Node() to @_rootNode")
		@_rootNode = new Node()

		console.log("Creating new DOMElement() and passing the @_rootNode")
		@_rootElement = new DOMElement(@_rootNode, 
				tagName: "div"
			)
		@_rootElement.id = "FramerContextRoot-#{@_name}"
		# @_rootElement.classList.add("framerContext")

		if @_parentLayer
			@_appendRootElement()
		else
			Utils.domComplete(@_appendRootElement)			

	_framerOriginal__appendRootElement: =>
		parentElement = @_parentLayer?._element
		parentElement ?= document.body
		parentElement.appendChild(@_rootElement)

	_appendRootElement: =>
		console.log("=== Context ===== ")
		
		parentElement = @_parentLayer?._element._node
		if not parentElement?
			console.log("Calls Engine.createScene()")
			parentElement = Engine.createScene()

		console.log("Calls parentElement.addChild passing @_rootElement._node")
		parentElement.addChild(@_rootElement._node)

	run: (f) ->
		previousContext = Framer.CurrentContext
		Framer.CurrentContext = @
		f()
		Framer.CurrentContext = previousContext

	@define "width", 
		get: -> 
			return @_parentLayer.width if @_parentLayer
			return window.innerWidth

	@define "height",
		get: -> 
			return @_parentLayer.height if @_parentLayer
			return window.innerHeight

