var EventEmitter = require("events").EventEmitter
  , assign = require("object-assign")
  , dispatcher = require("../dispatcher");

var BaseStore = assign({}, EventEmitter.prototype, {
  addChangeListener: function(callback) {
    this.on("change", callback);
  },
  removeChangeListener: function(callback) {
    this.removeListener("change", callback);
  },
  emitChange: function() {
    this.emit("change");
  }
});

module.exports = BaseStore;
