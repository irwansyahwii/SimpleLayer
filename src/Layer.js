// Generated by CoffeeScript 1.9.2
(function() {
  var Application, DOMElement, Events, FamousWindow, Layer, LayerId, Logger, Position, Quaternion, Rotation, Transitionable, _, famous,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  famous = require("famous");

  FamousWindow = require("./FamousWindow");

  Application = require("./Application");

  LayerId = require("./LayerId");

  Logger = require('./Logger');

  DOMElement = famous.domRenderables.DOMElement;

  Rotation = famous.components.Rotation;

  Position = famous.components.Position;

  Transitionable = famous.transitions.Transitionable;

  Events = require("./Events");

  Quaternion = famous.math.Quaternion;

  _ = require('./Underscore');

  Layer = (function() {
    function Layer(options) {
      this.on = bind(this.on, this);
      this.animate = bind(this.animate, this);
      this.startAnimation = bind(this.startAnimation, this);
      this.retrieveCurveValue = bind(this.retrieveCurveValue, this);
      this.applyOriginY = bind(this.applyOriginY, this);
      this.applyOriginX = bind(this.applyOriginX, this);
      this.applyIgnoreEvents = bind(this.applyIgnoreEvents, this);
      this.applyClip = bind(this.applyClip, this);
      this.applyVisible = bind(this.applyVisible, this);
      this.applyImage = bind(this.applyImage, this);
      this.applySuperlayer = bind(this.applySuperlayer, this);
      this.getSize = bind(this.getSize, this);
      this._centerUsingAlign = bind(this._centerUsingAlign, this);
      this.center = bind(this.center, this);
      this.centerY = bind(this.centerY, this);
      this.centerX = bind(this.centerX, this);
      this.centerAxis = bind(this.centerAxis, this);
      this.siblingLayers = bind(this.siblingLayers, this);
      this.removeSubLayer = bind(this.removeSubLayer, this);
      this.addSubLayer = bind(this.addSubLayer, this);
      this.subLayersByName = bind(this.subLayersByName, this);
      this.applyHtml = bind(this.applyHtml, this);
      this.applyRotationZ = bind(this.applyRotationZ, this);
      this.applyRotationY = bind(this.applyRotationY, this);
      this.applyRotationX = bind(this.applyRotationX, this);
      this.applyRotation = bind(this.applyRotation, this);
      this.radianToDegree = bind(this.radianToDegree, this);
      this.degreeToRadian = bind(this.degreeToRadian, this);
      this.applyOpacity = bind(this.applyOpacity, this);
      this.applyScale = bind(this.applyScale, this);
      this.applyScaleZ = bind(this.applyScaleZ, this);
      this.applyScaleY = bind(this.applyScaleY, this);
      this.applyScaleX = bind(this.applyScaleX, this);
      this.applyZ = bind(this.applyZ, this);
      this.applyY = bind(this.applyY, this);
      this.applyX = bind(this.applyX, this);
      this.applyBorderRadius = bind(this.applyBorderRadius, this);
      this.applyBackgroundColor = bind(this.applyBackgroundColor, this);
      this.applyWidth = bind(this.applyWidth, this);
      this.applyHeight = bind(this.applyHeight, this);
      var attributes, backgroundColor, borderRadius, height, image, width, x, y;
      this._id = LayerId.generateNewId();
      this._name = "";
      this._window = options.window;
      if (this._window == null) {
        this._window = Application.getRootWindow();
      }
      this._layerNode = this._window.createNode();
      this._layerNode.setOrigin(0.5, 0.5, 0.5);
      this._rotationY = 0;
      this._tagName = "div";
      this._ignoreEvents = false;
      image = options.image || null;
      attributes = null;
      if (image !== null) {
        this._tagName = "img";
      }
      this._layerElement = new DOMElement(this._layerNode, {
        tagName: this._tagName
      });
      if (image !== null) {
        this._layerElement.setAttribute("src", image);
      }
      backgroundColor = options.backgroundColor || null;
      if (backgroundColor !== null) {
        this.applyBackgroundColor(backgroundColor);
      }
      borderRadius = options.borderRadius || null;
      if (borderRadius !== null) {
        this.applyBorderRadius(borderRadius);
      }
      width = options.width || 0;
      height = options.height || 0;
      if (width >= 0) {
        this._layerNode.setSizeMode("absolute", "absolute", "absolute");
        this.applyWidth(width);
      }
      if (height >= 0) {
        this._layerNode.setSizeMode("absolute", "absolute", "absolute");
        this.applyHeight(height);
      }
      x = options.x || 0;
      y = options.y || 0;
      this.applyX(x);
      this.applyY(y);
      this._superlayer = options.superLayer || null;
      this.applySuperlayer(this._superlayer);
      this.eventsHandlers = [];
      this._layerNode.addUIEvent(Events.Click);
      this._layerNode.onReceive = (function(_this) {
        return function(event, payload) {
          var handler;
          if (!_this._ignoreEvents) {
            handler = _this.eventsHandlers[event] || null;
            if (handler !== null) {
              return handler();
            }
          }
        };
      })(this);
      this._layerNode.layer = this;
      this._layerElement.layer = this;
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
      var completeValueString;
      completeValueString = "";
      if (typeof borderRadius === 'string') {
        completeValueString = borderRadius;
      } else {
        completeValueString = borderRadius + "px";
      }
      this._layerElement.setProperty('border-radius', "" + completeValueString);
      return this._layerElement.setProperty('border', "1px solid " + this.backgroundColor);
    };

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

    Layer.prototype.applyZ = function(newVal) {
      var currentPos;
      currentPos = this._layerNode.getPosition();
      return this._layerNode.setPosition(currentPos[0], currentPos[1], newVal);
    };

    Layer.property('z', {
      get: function() {
        var currentPos;
        currentPos = this._layerNode.getPosition();
        return currentPos[2];
      },
      set: function(newVal) {
        if (this.y !== newVal) {
          return this.applyZ(newVal);
        }
      }
    });

    Layer.property('point', {
      get: function() {
        var point;
        point = {
          x: this.x,
          y: this.y
        };
        return point;
      },
      set: function(newVal) {
        if (this.point !== newVal) {
          if (newVal != null) {
            if (this.point.x !== newVal.x || this.point.y !== newVal.y) {
              this.x = newVal.x;
              return this.y = newVal.y;
            }
          }
        }
      }
    });

    Layer.property('size', {
      get: function() {
        var size;
        size = {
          width: this.width,
          height: this.height
        };
        return size;
      },
      set: function(newVal) {
        if (this.size !== newVal) {
          if (newVal != null) {
            if (this.size.width !== newVal.width || this.size.height !== newVal.height) {
              this.width = newVal.width;
              return this.height = newVal.height;
            }
          }
        }
      }
    });

    Layer.property('frame', {
      get: function() {
        var frame;
        frame = {
          x: this.x,
          y: this.y,
          width: this.width,
          height: this.height
        };
        return frame;
      },
      set: function(newVal) {
        if (this.frame !== newVal) {
          if (newVal != null) {
            this.point = newVal;
            return this.size = newVal;
          }
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

    Layer.prototype.applyScale = function(newVal) {
      this.applyScaleX(newVal);
      return this.applyScaleY(newVal);
    };

    Layer.property('scale', {
      get: function() {
        var currentScale;
        currentScale = this._layerNode.getScale();
        return currentScale[0];
      },
      set: function(newVal) {
        if (this.scale !== newVal) {
          return this.applyScale(newVal);
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

    Layer.prototype.degreeToRadian = function(degree) {
      var result;
      result = (degree * Math.PI) / 180.0;
      return result;
    };

    Layer.prototype.radianToDegree = function(radian) {
      var result;
      result = radian * 180.0 / Math.PI;
      return result;
    };

    Layer.prototype.applyRotation = function(newVal) {
      var currentRotation;
      currentRotation = this._layerNode.getRotation();
      return this._layerNode.setRotation(currentRotation[0], currentRotation[1], this.angleToFamousRotation(newVal));
    };

    Layer.property('rotation', {
      get: function() {
        var currentRotation, eulerResult, q, thetaRadian;
        currentRotation = this._layerNode.getRotation();
        q = new Quaternion(currentRotation[3], currentRotation[0], currentRotation[1], currentRotation[2]);
        eulerResult = {};
        q.toEuler(eulerResult);
        thetaRadian = Math.PI / 180.;
        return eulerResult.z / thetaRadian;
      },
      set: function(newVal) {
        if (this.rotation !== newVal) {
          return this.applyRotation(newVal);
        }
      }
    });

    Layer.prototype.applyRotationX = function(newVal) {
      var currentRotation;
      currentRotation = this._layerNode.getRotation();
      return this._layerNode.setRotation(this.degreeToRadian(newVal), currentRotation[1], currentRotation[2]);
    };

    Layer.property('rotationX', {
      get: function() {
        var currentRotation, eulerResult, q;
        currentRotation = this._layerNode.getRotation();
        q = new Quaternion(currentRotation[3], currentRotation[0], currentRotation[1], currentRotation[2]);
        eulerResult = {};
        q.toEuler(eulerResult);
        return this.radianToDegree(eulerResult.x);
      },
      set: function(newVal) {
        if (this.rotation !== newVal) {
          return this.applyRotationX(newVal);
        }
      }
    });

    Layer.prototype.applyRotationY = function(newVal) {
      var currentRotation;
      this._rotationY = newVal;
      currentRotation = this._layerNode.getRotation();
      return this._layerNode.setRotation(currentRotation[0], this.degreeToRadian(newVal), currentRotation[2]);
    };

    Layer.property('rotationY', {
      get: function() {
        return this._rotationY;
      },
      set: function(newVal) {
        if (this.rotation !== newVal) {
          return this.applyRotationY(newVal);
        }
      }
    });

    Layer.prototype.applyRotationZ = function(newVal) {
      var currentRotation;
      currentRotation = this._layerNode.getRotation();
      return this._layerNode.setRotation(currentRotation[0], currentRotation[1], this.angleToFamousRotation(newVal));
    };

    Layer.property('rotationZ', {
      get: function() {
        var currentRotation, eulerResult, q, thetaRadian;
        currentRotation = this._layerNode.getRotation();
        q = new Quaternion(currentRotation[3], currentRotation[0], currentRotation[1], currentRotation[2]);
        eulerResult = {};
        q.toEuler(eulerResult);
        thetaRadian = Math.PI / 180.;
        return eulerResult.z / thetaRadian;
      },
      set: function(newVal) {
        if (this.rotation !== newVal) {
          return this.applyRotationZ(newVal);
        }
      }
    });

    Layer.property('subLayers', {
      get: function() {
        var child, children, i, len, subLayers;
        subLayers = [];
        children = this._layerNode.getChildren() || [];
        for (i = 0, len = children.length; i < len; i++) {
          child = children[i];
          if (child.layer != null) {
            subLayers.push(child.layer);
          }
        }
        return subLayers;
      }
    });

    Layer.prototype.applyHtml = function(newVal) {
      return this._layerElement.setContent(newVal);
    };

    Layer.property('html', {
      get: function() {
        var values;
        values = this._layerElement.getValue();
        return values.content;
      },
      set: function(newVal) {
        if (this.html !== newVal) {
          return this.applyHtml(newVal);
        }
      }
    });

    Layer.prototype.subLayersByName = function(name) {
      var i, len, result, subLayer, subLayers;
      subLayers = this.subLayers;
      result = [];
      for (i = 0, len = subLayers.length; i < len; i++) {
        subLayer = subLayers[i];
        if (subLayer.name != null) {
          if (subLayer.name === name) {
            result.push(subLayer);
          }
        }
      }
      return result;
    };

    Layer.prototype.addSubLayer = function(layer) {
      if (layer != null) {
        return this._layerNode.addChild(layer._layerNode);
      }
    };

    Layer.prototype.removeSubLayer = function(layer) {
      if ((layer != null) && (layer._layerNode != null)) {
        return this._layerNode.removeChild(layer._layerNode);
      }
    };

    Layer.prototype.siblingLayers = function() {
      var child, i, len, parentChildren, result;
      result = [];
      parentChildren = this._layerNode.getParent().getChildren();
      for (i = 0, len = parentChildren.length; i < len; i++) {
        child = parentChildren[i];
        if (child.layer != null) {
          result.push(child.layer);
        }
      }
      return result;
    };

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
      this._layerNode.setAlign(0.5, 0.5);
      this._layerNode.setMountPoint(0.5, 0.5);
      return this._layerNode.setOrigin(0.5, 0.5);
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

    Layer.prototype.applySuperlayer = function(newVal) {
      if (newVal !== null) {
        this._layerNode.getParent().removeChild(this._layerNode);
        return newVal._layerNode.addChild(this._layerNode);
      }
    };

    Layer.property('superlayer', {
      get: function() {
        return this._superlayer;
      },
      set: function(newVal) {
        if (this._superlayer !== newVal) {
          this._superlayer = newVal;
          return this.applySuperlayer(newVal);
        }
      }
    });

    Layer.prototype.applyImage = function(imageUrl) {
      return this._layerElement.setProperty('background-image', "url('" + newVal + "')");
    };

    Layer.property('image', {
      get: function() {
        var elementValue;
        elementValue = this._layerElement.getValue();
        return elementValue.styles['background-image'];
      },
      set: function(newVal) {
        if (this.image !== newVal) {
          return this.applyImage(newVal);
        }
      }
    });

    Layer.prototype.applyVisible = function(newVal) {
      if (newVal) {
        return this._layerNode.show();
      } else {
        return this._layerNode.hide();
      }
    };

    Layer.property('visible', {
      get: function() {
        return this._layerNode.isShown();
      },
      set: function(newVal) {
        if (this.visible !== newVal) {
          return this.applyVisible(newVal);
        }
      }
    });

    Layer.prototype.applyClip = function(newVal) {
      return this._layerElement.setProperty('overflow', newVal);
    };

    Layer.property('clip', {
      get: function() {
        var elementValue;
        elementValue = this._layerElement.getValue();
        return elementValue.styles['overflow'];
      },
      set: function(newVal) {
        if (this.clip !== newVal) {
          return this.applyClip(newVal);
        }
      }
    });

    Layer.prototype.applyIgnoreEvents = function(newVal) {
      return this._ignoreEvents = newVal;
    };

    Layer.property('ignoreEvents', {
      get: function() {
        return this._ignoreEvents;
      },
      set: function(newVal) {
        if (this.ignoreEvents !== newVal) {
          return this.applyIgnoreEvents(newVal);
        }
      }
    });

    Layer.prototype.applyOriginX = function(newVal) {
      var currentValues;
      currentValues = this._layerNode.getOrigin();
      return this._layerNode.setOrigin(newVal, currentValues[1], currentValues[2]);
    };

    Layer.property('originX', {
      get: function() {
        var currentValues;
        currentValues = this._layerNode.getOrigin();
        return currentValues[0];
      },
      set: function(newVal) {
        if (this.originX !== newVal) {
          return this.applyOriginX(newVal);
        }
      }
    });

    Layer.prototype.applyOriginY = function(newVal) {
      var currentValues;
      currentValues = this._layerNode.getOrigin();
      return this._layerNode.setOrigin(currentValues[0], newVal, currentValues[2]);
    };

    Layer.property('originY', {
      get: function() {
        var currentValues;
        currentValues = this._layerNode.getOrigin();
        return currentValues[1];
      },
      set: function(newVal) {
        if (this.originY !== newVal) {
          return this.applyOriginY(newVal);
        }
      }
    });

    Layer.prototype.retrieveCurveValue = function(str) {
      var result;
      result = {
        name: "",
        args: []
      };
      if (_.endsWith(str, ")")) {
        result.name = str.split("(")[0];
        result.args = str.split("(")[1].split(",").map(function(a) {
          return _.trim(_.trimRight(a, ")"));
        });
      } else {
        result.name = str;
      }
      return result;
    };

    Layer.prototype.startAnimation = function(animOptions) {
      var borderRadiusTransition, borderRadiusValue, componentId, curveMaps, curveObject, curveValue, posXValue, posYValue, positionComponent, rotationComponent, rotationValue, rotationXValue, rotationYTransitionable, rotationYValue, rotationZValue, spinner, timeValue;
      rotationXValue = animOptions.properties.rotationX || null;
      rotationYValue = animOptions.properties.rotationY || null;
      rotationZValue = animOptions.properties.rotationZ || null;
      rotationValue = animOptions.properties.rotation || null;
      borderRadiusValue = animOptions.properties.borderRadius || null;
      posYValue = animOptions.properties.y || null;
      posXValue = animOptions.properties.x || null;
      timeValue = animOptions.time || 1;
      timeValue = timeValue * 1000;
      curveMaps = {
        "ease": "easeInOut"
      };
      curveValue = animOptions.curve || '';
      curveObject = this.retrieveCurveValue(curveValue);
      curveValue = curveObject.name;
      if (curveValue === "ease") {
        curveValue = "easeInOut";
      }
      if (posXValue !== null) {
        positionComponent = new Position(this._layerNode);
        positionComponent.setX(posXValue, {
          duration: timeValue
        });
      }
      if (posYValue !== null) {
        positionComponent = new Position(this._layerNode);
        positionComponent.setY(posYValue, {
          duration: timeValue
        });
      }
      if (rotationXValue !== null) {
        rotationComponent = new Rotation(this._layerNode);
        rotationComponent.setX(this.degreeToRadian(rotationXValue), {
          duration: timeValue
        });
      }
      if (rotationYValue !== null) {
        rotationYTransitionable = new Transitionable(this.rotationY);
        rotationYTransitionable.set(rotationYValue, {
          duration: timeValue
        });
        spinner = this._layerNode.addComponent({
          onUpdate: (function(_this) {
            return function(time) {
              _this.rotationY = rotationYTransitionable.get();
              if (rotationYTransitionable.isActive()) {
                return _this._layerNode.requestUpdate(spinner);
              }
            };
          })(this)
        });
        this._layerNode.requestUpdate(spinner);
      }
      if (rotationZValue !== null) {
        rotationComponent = new Rotation(this._layerNode);
        rotationComponent.setZ(this.degreeToRadian(rotationZValue), {
          duration: timeValue
        });
      }
      if (rotationValue !== null) {
        rotationComponent = new Rotation(this._layerNode);
        rotationComponent.setZ(this.angleToFamousRotation(rotationValue), {
          duration: timeValue,
          curve: curveValue
        });
        this._layerNode.addComponent(rotationComponent);
      }
      if (borderRadiusValue !== null) {
        Logger.log("borderRadius: " + this.borderRadius + ", borderRadiusValue: " + borderRadiusValue);
        borderRadiusTransition = new Transitionable(this.borderRadius);
        borderRadiusTransition.set(borderRadiusValue, {
          duration: 1000
        });
        componentId = this._layerNode.addComponent({
          onUpdate: (function(_this) {
            return function(time) {
              _this.borderRadius = borderRadiusTransition.get();
              if (borderRadiusTransition.isActive()) {
                return _this._layerNode.requestUpdate(componentId);
              }
            };
          })(this)
        });
        return this._layerNode.requestUpdate(componentId);
      }
    };

    Layer.prototype.animate = function(options) {
      var animOptions, delayValue;
      animOptions = options || {};
      animOptions.properties = animOptions.properties || {};
      delayValue = animOptions.delay || 0;
      delayValue = delayValue * 1000;
      return setTimeout((function(_this) {
        return function() {
          return _this.startAnimation(animOptions);
        };
      })(this), delayValue);
    };

    Layer.prototype.on = function(eventType, eventHandler) {
      return this.eventsHandlers[eventType] = eventHandler;
    };

    return Layer;

  })();

  module.exports = Layer;

}).call(this);
