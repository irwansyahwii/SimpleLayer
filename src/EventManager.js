// Generated by CoffeeScript 1.9.2
(function() {
  var EventManagerElement, EventManagerIdCounter, Utils, famous,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Utils = require("./Utils");

  EventManagerIdCounter = 0;

  famous = require("famous");

  EventManagerElement = (function() {
    function EventManagerElement(element1) {
      this.element = element1;
      this._events = {};
    }

    EventManagerElement.prototype.addEventListener = function(eventName, listener) {
      var base;
      if (this.element.constructor.name === "DOMElement") {

      } else {
        if (!Utils.domValidEvent(this.element, eventName)) {
          return;
        }
        if ((base = this._events)[eventName] == null) {
          base[eventName] = [];
        }
        this._events[eventName].push(listener);
        return this.element.addEventListener(eventName, listener);
      }
    };

    EventManagerElement.prototype.removeEventListener = function(eventName, listener) {
      if (!this._events) {
        return;
      }
      if (!this._events[eventName]) {
        return;
      }
      this._events[eventName] = _.without(this._events[eventName], listener);
      if (this.element.constructor.name === "DOMElement") {
        this.element._node.removeUIEvent(eventName);
      } else {
        this.element.removeEventListener(eventName, listener);
      }
    };

    EventManagerElement.prototype.removeAllEventListeners = function(eventName) {
      var eventListener, events, i, j, len, len1, ref;
      console.log("removeAllEventListeners called");
      events = eventName ? [eventName] : _.keys(this._events);
      for (i = 0, len = events.length; i < len; i++) {
        eventName = events[i];
        ref = this._events[eventName];
        for (j = 0, len1 = ref.length; j < len1; j++) {
          eventListener = ref[j];
          this.removeEventListener(eventName, eventListener);
        }
      }
    };

    EventManagerElement.prototype.once = function(event, listener) {
      var fn;
      fn = (function(_this) {
        return function() {
          _this.removeListener(event, fn);
          return listener.apply(null, arguments);
        };
      })(this);
      return this.on(event, fn);
    };

    EventManagerElement.prototype.on = EventManagerElement.prototype.addEventListener;

    EventManagerElement.prototype.off = EventManagerElement.prototype.removeEventListener;

    return EventManagerElement;

  })();

  exports.EventManager = (function() {
    function EventManager(element) {
      this.wrap = bind(this.wrap, this);
      this._elements = {};
    }

    EventManager.prototype.wrap = function(element) {
      if (!element._eventManagerId) {
        element._eventManagerId = EventManagerIdCounter++;
      }
      if (!this._elements[element._eventManagerId]) {
        this._elements[element._eventManagerId] = new EventManagerElement(element);
      }
      return this._elements[element._eventManagerId];
    };

    EventManager.prototype.reset = function() {
      var element, elementEventManager, ref, results;
      ref = this._elements;
      results = [];
      for (element in ref) {
        elementEventManager = ref[element];
        results.push(elementEventManager.removeAllEventListeners());
      }
      return results;
    };

    return EventManager;

  })();

}).call(this);
