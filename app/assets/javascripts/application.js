//= require jquery
//= require jquery_ujs
//= require fancybox
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require_tree ./lib
//= require ./store
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./routes
FF = Ember.Application.create({
	ready: function () {
		this.initialize();
		var router = FF.get("router")
			store = router.get("store"),
			current_record = FF.Task.findActive();

		/* Go to proper state */
		if( current_record ){
			router.get("applicationController").set("content", current_record);
			router.transitionTo("task");
		}
  }
});
//= require_tree .
