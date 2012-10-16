Ember.TextArea.reopen({
  attributeBindings: ['tabindex','autofocus',"spellcheck","rows","maxChars"],
  didInsertElement: function() {
  	//$('textarea').autogrow();

  	/* Set cursor on end */
  	var temp;
    temp=$('textarea').val();
    $('textarea').val('');
    $('textarea').focus();
    $('textarea').val(temp);
  },
  keyDown: function (e) {
  	if(e.which == 13) {
		  return false 
    }
  }
})