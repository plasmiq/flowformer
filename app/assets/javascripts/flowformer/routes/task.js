FF.TaskRoute = Ember.Route.extend({
  actions: {
    confirmTask: function() {
      var task = this.modelFor('task');
      task.set('createdAt', new Date());
      task.save();
    },
    startAgain: function() {
      this.transitionTo('welcome');
    },
    completeTask: function() {
      var task = this.modelFor('task');
      task.set('createdAt', task.get('createdAt'));
      task.set('completedAt', new Date());
      task.set('hadSucceed', true);
      task.save();
    },
    rejectTask: function() {
      var task = this.modelFor('task');
      task.set('createdAt', task.get('createdAt'));
      task.set('completedAt', new Date());
      task.set('hadSucceed', false);
      task.save();
    }
  },

  model: function() {
    return this.store.find('task', { completedAt: null }).then(function (result) {
      var task;
      if(result) {
        task = result.get('content')[0];
      }
      return task;
    });
  },

  afterModel: function(model) {
    if(!model) {
      this.transitionTo('welcome');
    }
  }
});
