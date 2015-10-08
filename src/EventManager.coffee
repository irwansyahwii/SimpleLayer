Utils = require "./Utils"

EventManagerIdCounter = 0

famous = require("famous")
# DOMElement = famous.domRenderables.DOMElement
# FamousEventMap = famous.domRenderers.Events.EventMap

class EventManagerElement

	constructor: (@element) ->
		@_events = {}

	addEventListener: (eventName, listener) ->

		# console.log "checking @element type: #{@element.constructor.name}"
		if @element.constructor.name is "DOMElement"
			# console.log "eventName: #{eventName}"

			# if FamousEventMap[eventName]
			# 	# console.log("Layer #{@element._layer.name} Subscribing to #{eventName}")
			# 	@_events[eventName] ?= []
			# 	@_events[eventName].push(listener)

			# 	@element._node.addUIEvent(eventName)

			# 	@element._node.onReceive = (event, payload) =>
			# 		# console.log("Layer #{@element._layer.name} onReceive: #{event}")
			# 		# console.log payload
			# 		payload.preventDefault = ->
			# 			payload.defaultPrevented = true

			# 		handlerArray = @_events[event]
			# 		# console.log "handlerArray:"
			# 		# console.log handlerArray
			# 		if handlerArray?
			# 			for handler in handlerArray
			# 				handler(payload)


		else
		
			# Filter out all the events that are not dom valid
			if not Utils.domValidEvent(@element, eventName)
				return

			@_events[eventName] ?= []
			@_events[eventName].push(listener)


			@element.addEventListener(eventName, listener)

	removeEventListener: (eventName, listener) ->
		
		return unless @_events
		return unless @_events[eventName]

		@_events[eventName] = _.without @_events[eventName], listener		

		if @element.constructor.name is "DOMElement"
			@element._node.removeUIEvent(eventName)	
		else
			@element.removeEventListener(eventName, listener)

		return

	removeAllEventListeners: (eventName) ->
		console.log("removeAllEventListeners called")

		events = if eventName then [eventName] else _.keys(@_events)

		for eventName in events
			for eventListener in @_events[eventName]
				@removeEventListener eventName, eventListener

		return

	once: (event, listener) ->

		fn = =>
			@removeListener event, fn
			listener arguments...

		@on event, fn

	on: @::addEventListener
	off: @::removeEventListener
	
class exports.EventManager

	constructor: (element) ->
		@_elements = {}

	wrap: (element) =>

		if not element._eventManagerId
			element._eventManagerId = EventManagerIdCounter++
		
		if not @_elements[element._eventManagerId]
			@_elements[element._eventManagerId] = new EventManagerElement(element)

		@_elements[element._eventManagerId]
	
	reset: ->
		for element, elementEventManager of @_elements
			elementEventManager.removeAllEventListeners()