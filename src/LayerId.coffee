class LayerId
    @currentId : 0
    @generateNewId: () ->
        @currentId += 1

        @currentId

module.exports = LayerId