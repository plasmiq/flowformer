FF.TaskController = Ember.ObjectController.extend({
  needs: ['time'],

  timerBinding: 'controllers.time.timer',
  untilMidnightBinding: 'controllers.time.untilMidnight',

  isCompletable: function() {
    var createdAt = moment(this.get('createdAt'));
    return createdAt.isAfter(moment().endOf('day'));
  }.property('createdAt', 'timer')
});