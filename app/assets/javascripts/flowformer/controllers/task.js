FF.TaskController = Ember.ObjectController.extend({
  needs: ['time'],

  timerBinding: 'controllers.time.timer',
  untilMidnightBinding: 'controllers.time.untilMidnight',

  isCompletable: function() {
    var createdAt = moment(this.get('createdAt'));
    return createdAt.isBefore(moment().startOf('day')) && !this.get('completedAt');
  }.property('createdAt', 'timer', 'completedAt')
});