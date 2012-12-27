Ember.TextArea.reopen({
  attributeBindings: ['tabindex','autofocus',"spellcheck","rows","maxChars"],
  didInsertElement: function() {
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
  },
  keyUp: function(e) {
    var limit = 50;
    var elem = $('textarea');
    //get the current text inside the textarea  
    var text = elem.val();  
    //count the number of characters in the text  
    var chars = text.length;  

    //check if there are more characters then allowed  
    if(chars > limit){  
        //and if there are use substr to get the text before the limit  
        var new_text = text.substr(0, limit);  

        //and change the current text with the new text  
        elem.val(new_text);  
    }  
  }
})