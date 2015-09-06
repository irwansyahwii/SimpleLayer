// Generated by CoffeeScript 1.9.2
(function() {
  var Application, DOMElement, FamousWindow, Layer, LayerId, Logger, famous,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  famous = require("famous");

  FamousWindow = require("./FamousWindow");

  Application = require("./Application");

  LayerId = require("./LayerId");

  Logger = require('./Logger');

  DOMElement = famous.domRenderables.DOMElement;

  Layer = (function() {
    function Layer(options) {
      this.applySuperlayer = bind(this.applySuperlayer, this);
      this.getSize = bind(this.getSize, this);
      this._centerUsingAlign = bind(this._centerUsingAlign, this);
      this.center = bind(this.center, this);
      this.centerY = bind(this.centerY, this);
      this.centerX = bind(this.centerX, this);
      this.centerAxis = bind(this.centerAxis, this);
      this.applyRotation = bind(this.applyRotation, this);
      this.applyOpacity = bind(this.applyOpacity, this);
      this.applyScaleZ = bind(this.applyScaleZ, this);
      this.applyScaleY = bind(this.applyScaleY, this);
      this.applyScaleX = bind(this.applyScaleX, this);
      this.applyY = bind(this.applyY, this);
      this.applyX = bind(this.applyX, this);
      this.addSubLayer = bind(this.addSubLayer, this);
      this.applyBorderRadius = bind(this.applyBorderRadius, this);
      this.applyBackgroundColor = bind(this.applyBackgroundColor, this);
      this.applyWidth = bind(this.applyWidth, this);
      this.applyHeight = bind(this.applyHeight, this);
      var backgroundColor, borderRadius, height, width, x, y;
      this._id = LayerId.generateNewId();
      this._name = "";
      this._window = options.window;
      if (this._window == null) {
        this._window = Application.getRootWindow();
      }
      this._layerNode = this._window.createNode();
      this._layerNode.setSizeMode("absolute", "absolute", "absolute");
      this._layerNode.setOrigin(0.5, 0.5);
      this._layerElement = new DOMElement(this._layerNode, {
        tagName: this._tagName
      });
      backgroundColor = options.backgroundColor || '#FFFFFF';
      this.applyBackgroundColor(backgroundColor);
      borderRadius = options.borderRadius || 0;
      this.applyBorderRadius(borderRadius);
      width = options.width || 0;
      height = options.height || 0;
      this.applyWidth(width);
      this.applyHeight(height);
      x = options.x || 0;
      y = options.y || 0;
      this.applyX(x);
      this.applyY(y);
    }

    Layer.prototype.applyHeight = function(val) {
      var currentSize;
      currentSize = this._layerNode.getAbsoluteSize();
      return this._layerNode.setAbsoluteSize(currentSize[0], val, currentSize[2]);
    };

    Layer.property('height', {
      get: function() {
        var currentSize;
        currentSize = this._layerNode.getAbsoluteSize();
        return currentSize[1];
      },
      set: function(newVal) {
        if (this.height !== newVal) {
          return this.applyHeight(newVal);
        }
      }
    });

    Layer.prototype.applyWidth = function(val) {
      var currentSize;
      currentSize = this._layerNode.getAbsoluteSize();
      return this._layerNode.setAbsoluteSize(val, currentSize[1], currentSize[2]);
    };

    Layer.property('width', {
      get: function() {
        var currentSize;
        Logger.log("width property inside");
        currentSize = this._layerNode.getAbsoluteSize();
        Logger.log("width property, currentSize: " + currentSize);
        return currentSize[0];
      },
      set: function(newVal) {
        if (this.width !== newVal) {
          return this.applyWidth(newVal);
        }
      }
    });

    Layer.prototype.applyBackgroundColor = function(bgColor) {
      return this._layerElement.setProperty("background-color", bgColor);
    };

    Layer.property('backgroundColor', {
      get: function() {
        var elementValue;
        elementValue = this._layerElement.getValue();
        return elementValue.styles['background-color'];
      },
      set: function(newVal) {
        if (this.backgroundColor !== newVal) {
          return this.applyBackgroundColor(newVal);
        }
      }
    });

    Layer.prototype.applyBorderRadius = function(borderRadius) {
      this._layerElement.setProperty('border-radius', borderRadius + "px");
      return this._layerElement.setProperty('border', borderRadius + "px solid " + this.backgroundColor);
    };

    Layer.prototype.addSubLayer = function(subLayer) {};

    Layer.property('borderRadius', {
      get: function() {
        var elementValue, strValue;
        elementValue = this._layerElement.getValue();
        strValue = elementValue.styles['borderRadius'] || '';
        if (strValue.length > 0) {
          strValue = strValue.replace("px", "");
          return parseInt(strValue, 10);
        } else {
          return 0;
        }
      },
      set: function(newVal) {
        if (this.borderRadius !== newVal) {
          return this.applyBorderRadius(newVal);
        }
      }
    });

    Layer.property('id', {
      get: function() {
        return this._id;
      }
    });

    Layer.property('name', {
      get: function() {
        return this._name;
      },
      set: function(newVal) {
        return this._name = newVal;
      }
    });

    Layer.prototype.applyX = function(newVal) {
      var currentPos;
      currentPos = this._layerNode.getPosition();
      return this._layerNode.setPosition(newVal, currentPos[1], currentPos[2]);
    };

    Layer.property('x', {
      get: function() {
        var currentPos;
        currentPos = this._layerNode.getPosition();
        return currentPos[0];
      },
      set: function(newVal) {
        if (this.x !== newVal) {
          return this.applyX(newVal);
        }
      }
    });

    Layer.prototype.applyY = function(newVal) {
      var currentPos;
      currentPos = this._layerNode.getPosition();
      return this._layerNode.setPosition(currentPos[0], newVal, currentPos[2]);
    };

    Layer.property('y', {
      get: function() {
        var currentPos;
        currentPos = this._layerNode.getPosition();
        return currentPos[1];
      },
      set: function(newVal) {
        if (this.y !== newVal) {
          return this.applyY(newVal);
        }
      }
    });

    Layer.property('minX', {
      get: function() {
        return this.x;
      }
    });

    Layer.property('maxX', {
      get: function() {
        return this.x + this.width;
      }
    });

    Layer.property('minY', {
      get: function() {
        return this.y;
      }
    });

    Layer.property('maxY', {
      get: function() {
        return this.y + this.height;
      }
    });

    Layer.property('midX', {
      get: function() {
        return (this.minX + this.maxX) / 2;
      }
    });

    Layer.property('midY', {
      get: function() {
        return (this.minY + this.maxY) / 2;
      }
    });

    Layer.prototype.applyScaleX = function(newVal) {
      var currentScale;
      currentScale = this._layerNode.getScale();
      return this._layerNode.setScale(newVal, currentScale[1], currentScale[2]);
    };

    Layer.prototype.applyScaleY = function(newVal) {
      var currentScale;
      currentScale = this._layerNode.getScale();
      return this._layerNode.setScale(currentScale[0], newVal, currentScale[2]);
    };

    Layer.prototype.applyScaleZ = function(newVal) {
      var currentScale;
      currentScale = this._layerNode.getScale();
      return this._layerNode.setScale(currentScale[0], currentScale[1], newVal);
    };

    Layer.property('scale', {
      get: function() {
        var currentScale;
        currentScale = this._layerNode.getScale();
        return currentScale[0];
      },
      set: function(newVal) {
        Logger.log("newVal scale: " + newVal);
        if (this.scale !== newVal) {
          this.applyScaleX(newVal);
          return this.applyScaleY(newVal);
        }
      }
    });

    Layer.prototype.applyOpacity = function(newVal) {
      return this._layerNode.setOpacity(newVal);
    };

    Layer.property('opacity', {
      get: function() {
        return this._layerNode.getOpacity();
      },
      set: function(newVal) {
        if (this.opacity !== newVal) {
          return this.applyOpacity(newVal);
        }
      }
    });

    Layer.prototype.applyRotation = function(newVal) {
      var thetaRadian;
      thetaRadian = 2 * Math.PI / 360.;
      return this._layerNode.setRotation(0, 0, newVal * thetaRadian);
    };

    Layer.property('rotation', {
      get: function() {
        var currentRotation, thetaRadian;
        currentRotation = this._layerNode.getRotation();
        thetaRadian = 2 * Math.PI / 360.;
        return currentRotation[2] / thetaRadian;
      },
      set: function(newVal) {
        if (this.rotation !== newVal) {
          return this.applyRotation(newVal);
        }
      }
    });

    Layer.prototype.centerAxis = function(isX, isY) {
      var nodeParent, parentClassName, parentSize;
      nodeParent = this._layerNode.getParent();
      parentSize = nodeParent.getAbsoluteSize();
      parentClassName = nodeParent.constructor.name;
      if (parentClassName === 'Scene') {
        parentSize = nodeParent.getUpdater().compositor.getContext('body')._size;
      }
      if (isX) {
        this.x = (parentSize[0] / 2) - (this.width / 2);
      }
      if (isY) {
        return this.y = (parentSize[1] / 2) - (this.height / 2);
      }
    };

    Layer.prototype.centerX = function() {
      return this.centerAxis(true, false);
    };

    Layer.prototype.centerY = function() {
      return this.centerAxis(false, true);
    };

    Layer.prototype.center = function() {
      return this.centerAxis(true, true);
    };

    Layer.prototype._centerUsingAlign = function() {
      var originalMountPoint;
      originalMountPoint = this._layerNode.getMountPoint();
      this._layerNode.setMountPoint(0.5, 0.5, originalMountPoint[2]);
      this._layerNode.setAlign(0.5, 0.5);
      return this._layerNode.setMountPoint(originalMountPoint[0], originalMountPoint[1], originalMountPoint[2]);
    };

    Layer.prototype.getSize = function() {
      return this._layerNode.getAbsoluteSize();
    };

    Layer.prototype.applySuperlayer = function() {};

    Layer.property('superlayer', {
      get: function() {
        return this._superlayer;
      },
      set: function(newVal) {
        if (this._superlayer !== newVal) {
          this._superlayer = newVal;
          return this.applySuperlayer();
        }
      }
    });

    return Layer;

  })();

  module.exports = Layer;

}).call(this);