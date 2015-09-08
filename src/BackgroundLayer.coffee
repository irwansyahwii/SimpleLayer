Layer = require("./Layer")

class BackgroundLayer extends Layer
    constructor:(options) ->
        options.properties = options.properties || {}

        delete options.width
        delete options.height

        # options.properties.zIndex = -10s

        super(options)

    bringToFront: () =>


module.exports = BackgroundLayer