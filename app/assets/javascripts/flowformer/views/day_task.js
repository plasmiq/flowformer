FF.DayTaskView = Ember.View.extend({

  tagName: "",

  task: function() {
    var daySeq = this.get("daySeq");
    var dayName = this.get("dayName");
    return this.get('controller').taskForDay(daySeq, dayName);
  }.property("daySeq", "dayName")
});