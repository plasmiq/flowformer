//= require jquery
//= require moment
//= require handlebars
//= require ember
//= require ember-data
//= require ember-localstorage-adapter
//= require_self
//= require_tree ./templates
FF = Ember.Application.create();

FF.LSAdapter = DS.LSAdapter.extend({
  namespace: 'FF'
});

FF.ApplicationAdapter = FF.LSAdapter;

FF.Router.map(function() {
  this.resource('welcome', { path: '/' });
  this.resource("history");
  this.resource("task");
});

FF.CurrentUser = DS.Model.extend({
  name: DS.attr('string')
});

FF.Task = DS.Model.extend({
  task_type: DS.attr('string'),
  text: DS.attr('string', {defaultValue: ""}),
  created_at: DS.attr('date'),
  completed_at: DS.attr('date'),
  completed: DS.attr('string')
});

FF.WelcomeRoute = Ember.Route.extend({
  actions: {
    createDoTask: function() {
      this.transitionTo('task');
    },
    createDontTask: function() {
      this.transitionTo('task');
    }
  },

  exit: function() {
    this.get('controller.currentUser').save();
  },

  setupController: function(controller, model) {
    this.store.find('currentUser').then( function(users) {
      var user = users.toArray()[0];
      if(!user) {
        user = this.store.createRecord('currentUser');
      }
      controller.set('currentUser', user);
    });
  }
});

FF.TimeController = Ember.Controller.extend({

  ticking: false,

  init: function() {
    if(!this.get('ticking')) {
      this.set('ticking',true);
      this.tick();
    }
  },

  tick: function () {
    this.notifyPropertyChange('untilMidnight');
    setTimeout(this.tick.bind(this), 1000)
  },

  untilMidnight: function() {
    var untilMidnight = new Date(),
      now  = untilMidnight.getTime();
    untilMidnight.setHours( 24 );
    untilMidnight.setMinutes( 0 );
    untilMidnight.setSeconds( 0 );
    untilMidnight.setMilliseconds( 0 );
    return untilMidnight - now;
  }.property(),

  timer: function() {
    return moment.utc( this.get("untilMidnight") ).format("HH:mm:ss")
  }.property("untilMidnight")
})

FF.WelcomeController = Ember.Controller.extend({
  currentUser: null,

  needs: ['time'],

  timerBinding: 'controllers.time.timer'
})

FF.WelcomeView = Ember.View.extend({
  classNames: ['welcome']
})
