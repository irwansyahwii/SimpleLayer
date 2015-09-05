famous = require("famous")

Engine = famous.core.FamousEngine;

Logger = require('./Logger')

class FamousWindow        
    constructor: () ->
        Logger.log 'FamousWindow constructor called'

        Logger.log 'Creating scene...'
        @scene = Engine.createScene();

    createNode: () =>

        newNode = @scene.addChild()

        newNode

module.exports = FamousWindow