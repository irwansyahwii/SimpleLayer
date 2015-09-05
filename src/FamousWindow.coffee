famous = require("famous")

Engine = famous.core.FamousEngine;

Logger = require('./Logger')

class FamousWindow        
    constructor: (options) ->
        options = options || {}

        Logger.log 'FamousWindow constructor called'

        Logger.log 'Creating scene...'
        @scene = Engine.createScene();

        @isRootWindow = options.isRootWindow || false

    createNode: () =>

        newNode = @scene.addChild()

        newNode


        

module.exports = FamousWindow