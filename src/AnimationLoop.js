// Generated by CoffeeScript 1.9.2
(function() {
  var Config, Engine, EventEmitter, Utils, _, famous, getTime,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  _ = require("./Underscore")._;

  Utils = require("./Utils");

  Config = require("./Config").Config;

  EventEmitter = require("./EventEmitter").EventEmitter;

  famous = require("famous");

  Engine = famous.core.FamousEngine;

  getTime = function() {
    return Utils.getTime() * 1000;
  };

  exports.AnimationLoop = (function(superClass) {
    extend(AnimationLoop, superClass);

    function AnimationLoop() {
      this.start = bind(this.start, this);
      this._framerOriginalStart = bind(this._framerOriginalStart, this);
      this.delta = 1 / 60;
      this.raf = true;
      if (Utils.webkitVersion() > 600 && Utils.isDesktop()) {
        this.raf = false;
      }
      if (Utils.webkitVersion() > 600 && Utils.isFramerStudio()) {
        this.raf = false;
      }
    }

    AnimationLoop.prototype._framerOriginalStart = function() {
      var _timestamp, animationLoop, tick, update;
      animationLoop = this;
      _timestamp = getTime();
      update = function() {
        var delta, timestamp;
        if (animationLoop.delta) {
          delta = animationLoop.delta;
        } else {
          timestamp = getTime();
          delta = (timestamp - _timestamp) / 1000;
          _timestamp = timestamp;
        }
        animationLoop.emit("update", delta);
        return animationLoop.emit("render", delta);
      };
      tick = function(timestamp) {
        if (animationLoop.raf) {
          update();
          return window.requestAnimationFrame(tick);
        } else {
          return window.setTimeout(function() {
            update();
            return window.requestAnimationFrame(tick);
          }, 0);
        }
      };
      return tick();
    };

    AnimationLoop.prototype.start = function() {
      var _timestamp, animationLoop, update, updater;
      console.log("==== AnimationLoop ====");
      animationLoop = this;
      _timestamp = getTime();
      update = function() {
        var delta, timestamp;
        if (animationLoop.delta) {
          delta = animationLoop.delta;
        } else {
          timestamp = getTime();
          delta = (timestamp - _timestamp) / 1000;
          _timestamp = timestamp;
        }
        animationLoop.emit("update", delta);
        return animationLoop.emit("render", delta);
      };
      updater = {
        onUpdate: (function(_this) {
          return function() {
            update();
            return Engine.requestUpdate(updater);
          };
        })(this)
      };
      console.log("Calling Engine.init");
      Engine.init();
      console.log("Calling Engine.requestUpdate(updater)");
      return Engine.requestUpdate(updater);
    };

    return AnimationLoop;

  })(EventEmitter);

}).call(this);
