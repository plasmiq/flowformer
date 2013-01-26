FF.TaskHistoryController = Ember.ObjectController.extend({
  completedAt: null,
	selectedTask: null,
  completed: null,
  currentMonthTasks: null,
  previousMonthTasks: null,
  currentMonth: null,
  previousMonth: null,

  setup: function() {
    this.set('currentMonthTasks', FF.Task.findAllTasks());
    this.set('currentMonth', $.format.date(Date.now(), 'MMM'));
  },
  setCompleted: function() {
    if(this.selectedTask) {
      this.set('completed', (this.selectedTask.get('completed') ? 'success' : 'fail'));
    }
  },
  setCompletedAt: function() {
    if(this.selectedTask) {
      this.set('completedAt', $.format.date(this.selectedTask.get('completed_at'), "ddd dd MMM yyyy"));
    }
  },
	selectTask: function(task) {
		this.set('selectedTask', task.context);
    this.setCompleted();
    this.setCompletedAt();
	}
})
