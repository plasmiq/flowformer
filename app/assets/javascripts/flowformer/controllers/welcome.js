FF.WelcomeController = Ember.Controller.extend({
  currentUser: null,

  needs: ['time'],

  timerBinding: 'controllers.time.timer'
});