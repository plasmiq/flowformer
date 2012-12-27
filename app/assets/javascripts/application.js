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
		var router = FF.get("router");
		var store = router.get("store");
		var records = store.findAll(FF.Task).toArray();
		var current_record = false;

		$.each(records, function(index, record) {
			if(record.get('completed') == null){
				current_record = record;
			}
		});

		
		if( current_record ){
			// go to proper state
			router.get("applicationController").set("content", current_record);
			router.transitionTo("task");
		}
  }
});
//= require_tree .
