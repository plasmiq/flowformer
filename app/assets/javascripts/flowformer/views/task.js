FF.TaskView = Ember.View.extend({
  classNames: ['task'],

  classNameBindings: ['controller.isDoTask:do:dont'],

  progress: function() {
    var percentage,
      milisecondsPerDay = 86400000,
      milisecondsUntilMindnight = this.get("controller.untilMidnight")

    percentage = 100 * (1 - (milisecondsUntilMindnight/milisecondsPerDay));

    return "min-width: "+percentage+ "%";
  }.property("controller.untilMidnight"),

  placeholder: function() {
    var placeholder;
    if(this.get('controller.isDoTask')) {
      placeholder = "Type one thing you're to do before tomorrow."
    } else {
      placeholder = "Type one thing you're not to do before tomorrow."
    }
    return placeholder;
  }.property('controller.isDoTask'),

  progressText: function() {
    var text;
    if(this.get('controller.isCreatedToday')) {
      text = this.get('controller.timer')
    } else {
      if(this.get('controller.isDoTask')) {
        text = 'MUST DO COMPLETE!';
      } else {
        text = 'DONT DO COMPLETE!'
      }
    }
    return text;
  }.property('controller.isDoTask', 'controller.timer'),

  didInsertElement: function() {
    var text = document.querySelector("#task textarea")

    var resize = function() {
      onlyPlaceholder = false

      if(text.value == "") {
        text.value = text.placeholder
        onlyPlaceholder = true
      }

      text.style.height = 'auto';
      text.style.height = text.scrollHeight+'px';

      if(onlyPlaceholder) {
        text.value = ""
      }
    }

    var observe = function(element, event, handler) {
      element.addEventListener(event, handler, false);
    }

    delayedResize = function() {
      window.setTimeout(resize, 0);
    }

    observe(text, 'change',  resize);
    observe(text, 'cut',     delayedResize);
    observe(text, 'paste',   delayedResize);
    observe(text, 'drop',    delayedResize);
    observe(text, 'keydown', delayedResize);
    observe(window, 'resize', delayedResize);

    if(!this.get("controller.completed")){
      delayedResize()
    }
  }
})