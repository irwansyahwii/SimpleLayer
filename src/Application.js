// Generated by CoffeeScript 1.9.2
(function() {
  var Application, Engine, FamousWindow, Logger, famous;

  famous = require("famous");

  Engine = famous.core.FamousEngine;

  FamousWindow = require("./FamousWindow");

  Logger = require("./Logger");

  Function.prototype.getter = function(prop, get) {
    return Object.defineProperty(this.prototype, prop, {
      get: get,
      configurable: true
    });
  };

  Function.prototype.setter = function(prop, set) {
    return Object.defineProperty(this.prototype, prop, {
      set: set,
      configurable: true
    });
  };

  Function.prototype.property = function(prop, desc) {
    return Object.defineProperty(this.prototype, prop, desc);
  };

  Application = (function() {
    function Application() {}

    Application.rootWindow = null;

    Application.hasInitialized = false;

    Application.isReady = false;

    Application.run = function(mainFn) {
      var poolContext;
      poolContext = function() {
        var ctx, rootWin;
        rootWin = Application.getRootWindow();
        ctx = rootWin.scene.getUpdater().getContext('body');
        if (ctx != null) {
          if (mainFn !== null) {
            return mainFn();
          }
        } else {
          return setTimeout(function() {
            return poolContext();
          }, 1);
        }
      };
      return poolContext();
    };

    Application.init = function() {
      var rootWin;
      if (!Application.hasInitialized) {
        Logger.log("Initializing application...");
        Application.hasInitialized = true;
        rootWin = Application.getRootWindow();
        Logger.log("Initializing famous engine...");
        return Engine.init();
      }
    };

    Application.getRootWindow = function() {
      if (Application.rootWindow === null) {
        Logger.log("Creating a new window for root window...");
        Application.rootWindow = new FamousWindow({
          isRootWindow: true
        });
        Application.init();
      }
      Logger.log('Application.rootWindow:');
      Logger.log(Application.rootWindow);
      return Application.rootWindow;
    };

    return Application;

  })();

  module.exports = Application;

}).call(this);
