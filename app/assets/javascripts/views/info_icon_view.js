FF.InfoIconView = Em.View.extend({
	tagName: "a",
	classNames: ["infoicon"],
	
	didInsertElement: function() {
		this.$().fancybox({
			content: "&nbsp;",
			afterLoad: function() {
				$(".info").appendTo(".fancybox-inner");
			},
			beforeClose: function() {
				$(".info").appendTo("#info");
			}
		})
	}
})