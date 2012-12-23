// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require fancybox
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require flowformer
FF = Ember.Application.create({
	ready: function () {
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
