FF.Date = Ember.Object.extend({
  year: null,
  month: null,

  init: function(options) {
    this._super;
    options = options || {}
    this.set('year', (options['year'] || (new Date).getFullYear())); 
    this.set('month', ((typeof(options['month']) == 'number') ? options['month'] :  (new Date).getMonth()));
  },

  nextMonth: function() {
    var _month = this.get('month');

    if(_month == 11) {
      this.set('year', this.get('year') + 1); 
      this.set('month', 0);
    } else {
      this.set('month', _month + 1);
    }
  },

  prevMonth: function() {
    var _month = this.get('month');

    if(_month == 0) {
      this.set('year', this.get('year') - 1); 
      this.set('month', 11);
    } else {
      this.set('month', _month - 1);
    }
  }
});
