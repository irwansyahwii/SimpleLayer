// Generated by CoffeeScript 1.9.2
(function() {
  var Defaults, Integrator, Simulator, Utils,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Utils = require("../Utils");

  Defaults = require("../Defaults").Defaults;

  Simulator = require("../Simulator").Simulator;

  Integrator = require("../Integrator").Integrator;

  exports.SpringSimulator = (function(superClass) {
    extend(SpringSimulator, superClass);

    function SpringSimulator() {
      this.finished = bind(this.finished, this);
      return SpringSimulator.__super__.constructor.apply(this, arguments);
    }

    SpringSimulator.prototype.setup = function(options) {
      this.options = Defaults.getDefaults("SpringSimulator", options);
      this.options = _.defaults(options, {
        velocity: 0,
        position: 0,
        offset: 0
      });
      this._state = {
        x: this.options.position,
        v: this.options.velocity
      };
      return this._integrator = new Integrator((function(_this) {
        return function(state) {
          return -_this.options.tension * state.x - _this.options.friction * state.v;
        };
      })(this));
    };

    SpringSimulator.prototype.next = function(delta) {
      this._state = this._integrator.integrateState(this._state, delta);
      return this.getState();
    };

    SpringSimulator.prototype.finished = function() {
      var positionNearZero, velocityNearZero;
      positionNearZero = Math.abs(this._state.x) < this.options.tolerance;
      velocityNearZero = Math.abs(this._state.v) < this.options.tolerance;
      return positionNearZero && velocityNearZero;
    };

    SpringSimulator.prototype.setState = function(state) {
      return this._state = {
        x: state.x - this.options.offset,
        v: state.v
      };
    };

    SpringSimulator.prototype.getState = function() {
      var state;
      return state = {
        x: this._state.x + this.options.offset,
        v: this._state.v
      };
    };

    return SpringSimulator;

  })(Simulator);

}).call(this);
