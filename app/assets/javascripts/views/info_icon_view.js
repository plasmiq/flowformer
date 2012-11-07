FF.InfoIconView = Em.View.extend({
	tagName: "a",
	classNames: ["infoicon"],
	
	click: function() {
		var infoView = Em.View.create({
			templateName: "info",
			didInsertElement: function() {
				//Twitter widgets Init
				!function(d,s,id){
					var js,fjs=d.getElementsByTagName(s)[0];			
					js=d.createElement(s);
					js.id=id;
					js.src="//platform.twitter.com/widgets.js";
					fjs.parentNode.insertBefore(js,fjs);
				}(document,"script","twitter-wjs");

				//Fancybox init
				$.fancybox( $("#info"), {
					beforeClose: function() {
						infoView.destroy()
					}
				} )
			}
		});
		infoView.appendTo("body");
	}
})