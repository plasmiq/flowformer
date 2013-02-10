FF.TaskHistoryMonthView = Ember.CollectionView.extend({
  classNames: ['month-view'],
  itemViewClass: Ember.View.extend({
    templateName: "task_history/month_view",
    taskBinding: "content",
    dayName: function() {
    	var days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
    	return days[ this.get("contentIndex") ];
    }.property("contentIndex")
  })
})