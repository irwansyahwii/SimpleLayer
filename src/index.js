// Generated by CoffeeScript 1.9.2
(function() {
  var Application, Layer, Logger;

  Logger = require('./Logger');

  Layer = require("./Layer");

  Application = require('./Application');

  Application.run(function() {
    var layerA, layerB;
    layerA = new Layer({
      width: 260,
      height: 260,
      backgroundColor: "green"
    });
    layerB = new Layer({
      width: 60,
      height: 60,
      backgroundColor: "#2DD7AA",
      scale: 1,
      borderRadius: 3
    });
    layerB.superlayer = layerA;
    layerB.centerX();
    return Logger.log("layerB.x: " + layerB.x);
  });

}).call(this);
