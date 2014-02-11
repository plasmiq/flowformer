FF.WelcomeRoute = Ember.Route.extend({
  actions: {
    createDoTask: function() {
      var task = this.store.createRecord('task', {
        type: 'do'
      });
      task.save();
      this.transitionTo('task');
    },
    createDontTask: function() {
      var task = this.store.createRecord('task', {
        type: 'dont'
      });
      task.save();
      this.transitionTo('task');
    }
  },

  beforeModel: function() {
    var taskController = this.controllerFor('task'),
      task = taskController.get('model');
    if(task) {
      // this.transitionTo('task');
    }
  },

  exit: function() {
    this.get('controller.currentUser').save();
  },

  setupController: function(controller, model) {
    var store = this.store;

    store.find('currentUser').then(function(result) {
      var user = result.get('content')[0];
      if(!user) {
        user = store.createRecord('currentUser');
      }
      controller.set('currentUser', user);
    });
  }
});
