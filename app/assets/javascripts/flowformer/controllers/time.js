FF.TimeController = Ember.Controller.extend({

  ticking: false,

  init: function() {
    if(!this.get('ticking')) {
      this.set('ticking',true);
      this.tick();
    }
  },

  tick: function () {
    this.notifyPropertyChange('untilMidnight');
    setTimeout(this.tick.bind(this), 1000)
  },

  untilMidnight: function() {
    var untilMidnight = new Date(),
      now  = untilMidnight.getTime();
    untilMidnight.setHours( 24 );
    untilMidnight.setMinutes( 0 );
    untilMidnight.setSeconds( 0 );
    untilMidnight.setMilliseconds( 0 );
    return untilMidnight - now;
  }.property(),

  timer: function() {
    return moment.utc( this.get("untilMidnight") ).format("HH:mm:ss")
  }.property("untilMidnight")
});