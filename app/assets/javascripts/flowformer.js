//= require_tree ./lib
//= require ./store
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./routes
//= require_self

FF.initialize();

// Initialize states

//if( FF.Task && FF.Task.completed === null ) {
//  FF.get('router').transitionTo("root.task")
//} else if ( FF.Task && FF.Task.completed != null ) {
//  FF.get('router').transitionTo("root.completed")	
//}