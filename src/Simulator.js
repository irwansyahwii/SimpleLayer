// Generated by CoffeeScript 1.9.2
(function() {
  var BaseClass, Config, Utils, _,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Utils = require("./Utils");

  _ = require("./Underscore")._;

  Config = require("./Config").Config;

  BaseClass = require("./BaseClass").BaseClass;

  exports.Simulator = (function(superClass) {
    "The simulator class runs a physics simulation based on a set of input values \nat setup({input values}), and emits an output state {x, v}";
    extend(Simulator, superClass);

    Simulator.define("state", {
      get: function() {
        return _.clone(this._state);
      },
      set: function(state) {
        return this._state = _.clone(state);
      }
    });

    function Simulator(options) {
      if (options == null) {
        options = {};
      }
      this._state = {
        x: 0,
        v: 0
      };
      this.options = null;
      this.setup(options);
    }

    Simulator.prototype.setup = function(options) {
      throw Error("Not implemented");
    };

    Simulator.prototype.next = function(delta) {
      throw Error("Not implemented");
    };

    Simulator.prototype.finished = function() {
      throw Error("Not implemented");
    };

    return Simulator;

  })(BaseClass);

}).call(this);