famous = require("famous")

Engine = famous.core.FamousEngine;


class Clock
    @getTime: () =>
        Engine.getClock().getTime()

module.exports = Clock