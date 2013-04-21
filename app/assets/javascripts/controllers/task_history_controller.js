FF.TaskHistoryController = Ember.ObjectController.extend({
  completedAt: null,
	selectedTask: null,
  completed: null,
  currentMonthTasks: null,
  previousMonthTasks: null,
  currentMonth: null,
  prevMonth: null,
  prevYear: null,
  currentYear: null,
  months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
  humanCurrentMonth: null,
  humanPrevMonth: null,
  cssClass: null,

  initDates: function() {
    var _date = new FF.Date;
    var _currentYear = _date.get('year');
    var _currentMonth = _date.get('month');

    this.set('currentYear', _currentYear);
    this.set('currentMonth', _currentMonth);

    _date.prevMonth();

    this.set('prevYear', _date.get('year'));
    this.set('prevMonth', _date.get('month'));
  },

  setCurrentMonthTask: function() {
    this.set('currentMonthTasks', FF.Task.findForHistory({
      month: this.get('currentMonth'),
      year: this.get('currentYear')
    }));
  }.observes('currentMonth'),

  setPreviousMonthTask: function() {
    this.set('previousMonthTasks', FF.Task.findForHistory({
      month: this.get('prevMonth'),
      year: this.get('prevYear')
    }));
  }.observes('prevMonth'),

  setCompleted: function() {
    if(this.selectedTask) {
      this.set('completed', (this.selectedTask.get('completed') == 'true' ? 'success' : 'fail'));
    }
  }.observes('selectedTask'),

  setCompletedAt: function() {
    if(this.selectedTask) {
      this.set('completedAt', $.format.date(this.selectedTask.get('completed_at'), "ddd dd MMM yyyy"));
    }
  }.observes('selectedTask'),

	selectTask: function(task) {
    this.set('selectedTask', task.context);
    taskStatus = this.selectedTask.get('completed') == 'true' ? 'success' : 'fail';
    this.set('cssClass', 'task_selected_' + taskStatus);
	},

  selectNextMonth: function() {
    var _currentYear = this.get('currentYear');
    var _currentMonth = this.get('currentMonth');
    var _date = new FF.Date({year: _currentYear, month: _currentMonth});

    this.set('prevYear', _currentYear);
    this.set('prevMonth', _currentMonth);

    _date.nextMonth();

    this.set('currentMonth', _date.get('month'));
    this.set('currentYear', _date.get('year'));
  },

  selectPrevMonth: function() {
    var _prevYear = this.get('prevYear');
    var _prevMonth = this.get('prevMonth');
    var _date = new FF.Date({year: _prevYear, month: _prevMonth});

    this.set('currentYear', _prevYear);
    this.set('currentMonth', _prevMonth);

    _date.prevMonth();

    this.set('prevMonth', _date.get('month'));
    this.set('prevYear', _date.get('year'));
  },

  setHumanCurrentMonth: function() {
    this.set('humanCurrentMonth', this.get('months')[this.get('currentMonth')]);
  }.observes('currentMonth'),

  setHumanPrevMonth: function() {
    this.set('humanPrevMonth', this.get('months')[this.get('prevMonth')]);
  }.observes('prevMonth')
})
