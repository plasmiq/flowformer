FF.HistoryController = Ember.Controller.extend({
  monthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
  dayNames: ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"],
  daySeqs: [0, 1, 2, 3, 4, 5],

  year: 2014,

  month: 2,

  daysOfMonth: function() {
    var month = this.get("month");
    var year = this.get("year");
    var days = { 0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6: [] }
    var i = 1;
    var day, date;
    if(month.length != 2) {
      month = "0%@".fmt(month);
    }
    for(i; i <= 31; i++) {
      day = (i < 10) ? "0%@".fmt(i) : i;
      date = "%@-%@-%@".fmt(year,month,day);
      days[moment(date).day()].push(date)
    }
    return days;
  }.property("year", "month"),

  taskRepository: function() {
    var tasks = {};
    this.get("model").forEach(function(task) {
      var date = moment(task.get('createdAt')).format("YYYY-MM-DD");
      tasks[date] = task;
    });
    return tasks;
  }.property("model.@each"),

  translateDate: function(daySeq, dayName) {
    var idx = this.get("dayNames").indexOf(dayName)+1
    if(idx === 7) { idx = 0; };
    return this.get("daysOfMonth")[idx][daySeq]
  },

  taskForDay: function(daySeq, dayName) {
    var date = this.translateDate(daySeq, dayName);
    return this.get("taskRepository")[date];
  }
});
