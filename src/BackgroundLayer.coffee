Layer = require("./Layer")

class BackgroundLayer extends Layer
    constructor:(options) ->
        options.properties = options.properties || {}

        options.width = -1
        options.height = -1

        # options.properties.zIndex = -10s

        super(options)


module.exports = BackgroundLayer