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
    @isReady: false

    @run: (mainFn) ->
        poolContext = ->            
            rootWin = Application.getRootWindow()

            # ctx = rootWin.scene.getUpdater().getContext('body')
            ctx = rootWin.scene.getUpdater().compositor.getContext('body')
            Logger.log "ctx: #{ctx}"
            if ctx?
                if mainFn isnt null
                    mainFn()
            else
                setTimeout ->
                        poolContext()
                    , 1
        poolContext()

    @init: () ->
        if not Application.hasInitialized
            Logger.log "Initializing application..."
            Application.hasInitialized = true
            rootWin = Application.getRootWindow()

            Logger.log "Initializing famous engine..."
            Engine.init()


    @getRootWindow: () ->
        if Application.rootWindow is null
            Logger.log "Creating a new window for root window..."
            Application.rootWindow = new FamousWindow(
                    isRootWindow: true
                )
            Application.init()

        Logger.log 'Application.rootWindow:'
        Logger.log Application.rootWindow

        Application.rootWindow

module.exports = Application