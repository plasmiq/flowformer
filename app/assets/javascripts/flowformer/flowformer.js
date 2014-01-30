//= require jquery
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require_tree ./templates
FF = Ember.Application.create();

FF.Router.map(function() {
  // put your routes here
});

FF.IndexRoute = Ember.Route.extend({
  model: function() {
    return ['red', 'yellow', 'blue'];
  }
});

console.log("sss")