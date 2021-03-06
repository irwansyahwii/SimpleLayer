// Generated by CoffeeScript 1.9.2
(function() {
  var ChromeAlert, Utils, _,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  _ = require("./Underscore")._;

  Utils = require("./Utils");

  ChromeAlert = "Importing layers is currently only supported on Safari. If you really want it to work with Chrome quit it, open a terminal and run:\nopen -a Google\ Chrome -–allow-file-access-from-files";

  exports.Importer = (function() {
    function Importer(path1, extraLayerProperties) {
      this.path = path1;
      this.extraLayerProperties = extraLayerProperties != null ? extraLayerProperties : {};
      this.paths = {
        layerInfo: Utils.pathJoin(this.path, "layers.json"),
        images: Utils.pathJoin(this.path, "images"),
        documentName: this.path.split("/").pop()
      };
      this._createdLayers = [];
      this._createdLayersByName = {};
    }

    Importer.prototype.load = function() {
      var i, j, layer, layerInfo, layersByName, len, len1, ref, ref1;
      layersByName = {};
      layerInfo = this._loadlayerInfo();
      layerInfo.map((function(_this) {
        return function(layerItemInfo) {
          return _this._createLayer(layerItemInfo);
        };
      })(this));
      ref = this._createdLayers;
      for (i = 0, len = ref.length; i < len; i++) {
        layer = ref[i];
        this._correctLayer(layer);
      }
      ref1 = this._createdLayers;
      for (j = 0, len1 = ref1.length; j < len1; j++) {
        layer = ref1[j];
        if (!layer.superLayer) {
          layer.superLayer = null;
        }
      }
      return this._createdLayersByName;
    };

    Importer.prototype._loadlayerInfo = function() {
      var importedKey, ref;
      importedKey = this.paths.documentName + "/layers.json.js";
      if ((ref = window.__imported__) != null ? ref.hasOwnProperty(importedKey) : void 0) {
        return window.__imported__[importedKey];
      }
      return Framer.Utils.domLoadJSONSync(this.paths.layerInfo);
    };

    Importer.prototype._createLayer = function(info, superLayer) {
      var LayerClass, layer, layerInfo, ref;
      LayerClass = Layer;
      layerInfo = {
        shadow: true,
        name: info.name,
        frame: info.layerFrame,
        clip: false,
        backgroundColor: null,
        visible: (ref = info.visible) != null ? ref : true
      };
      _.extend(layerInfo, this.extraLayerProperties);
      if (info.image) {
        layerInfo.frame = info.image.frame;
        layerInfo.image = Utils.pathJoin(this.path, info.image.path);
      }
      if (info.maskFrame) {
        layerInfo.frame = info.maskFrame;
        layerInfo.clip = true;
      }
      if (info.children.length === 0 && indexOf.call(_.pluck(superLayer != null ? superLayer.superLayers() : void 0, "clip"), true) >= 0) {
        layerInfo.frame = info.image.frame;
        layerInfo.clip = false;
      }
      if (superLayer != null ? superLayer.contentLayer : void 0) {
        layerInfo.superLayer = superLayer.contentLayer;
      } else if (superLayer) {
        layerInfo.superLayer = superLayer;
      }
      layer = new LayerClass(layerInfo);
      layer.name = layerInfo.name;
      if (layerInfo.name.toLowerCase().indexOf("scroll") !== -1) {
        layer.scroll = true;
      }
      if (layerInfo.name.toLowerCase().indexOf("draggable") !== -1) {
        layer.draggable.enabled = true;
      }
      if (!layer.image && !info.children.length && !info.maskFrame) {
        layer.frame = Utils.frameZero();
      }
      _.clone(info.children).reverse().map((function(_this) {
        return function(info) {
          return _this._createLayer(info, layer);
        };
      })(this));
      if (!layer.image && !info.maskFrame) {
        layer.frame = layer.contentFrame();
      }
      layer._info = info;
      this._createdLayers.push(layer);
      return this._createdLayersByName[layer.name] = layer;
    };

    Importer.prototype._correctLayer = function(layer) {
      var traverse;
      traverse = function(layer) {
        var i, len, ref, results, subLayer;
        if (layer.superLayer) {
          layer.frame = Utils.convertPoint(layer.frame, null, layer.superLayer);
        }
        ref = layer.subLayers;
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          subLayer = ref[i];
          results.push(traverse(subLayer));
        }
        return results;
      };
      if (!layer.superLayer) {
        return traverse(layer);
      }
    };

    return Importer;

  })();

  exports.Importer.load = function(path) {
    var importer;
    importer = new exports.Importer(path);
    return importer.load();
  };

}).call(this);
