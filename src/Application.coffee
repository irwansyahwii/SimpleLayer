famous = require("famous")

Engine = famous.core.FamousEngine;

FamousWindow = require("./FamousWindow")

Logger = require("./Logger")

Function::getter = (prop, get) ->
  Object.defineProperty @prototype, prop, {get, configurable: yes}

Function::setter = (prop, set) ->
  Object.defineProperty @prototype, prop, {set, configurable: yes}

Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc  

class Application

    @rootWindow: null
    @hasInitialized: false

    @init: () ->
        if not Application.hasInitialized
            Logger.log "Initializing application..."
            Application.hasInitialized = true
            Application.getRootWindow()

            Logger.log "Initializing famous engine..."
            Engine.init()


    @getRootWindow: () ->
        if Application.rootWindow is null
            Logger.log "Creating a new window for root window..."
            Application.rootWindow = new FamousWindow()
            Application.init()

        Logger.log 'Application.rootWindow:'
        Logger.log Application.rootWindow

        Application.rootWindow

module.exports = Application