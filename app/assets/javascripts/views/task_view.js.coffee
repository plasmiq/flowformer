@FF.TaskView = Ember.View.extend
    templateName: "task"
    classNames: ["task"]
    classNameBindings: ["is100","completed",'controller.task_type']

    is100: (->
        "is100" if @get("controller.completable")
    ).property("controller.completable")

    progress: (->
        hoursLeft = @get("controller.hoursLeft")
        percentage = (24 - hoursLeft) / 24  * 100
        if( percentage > 10 && percentage <=  100 )
            "min-width: " + percentage + "%"
    ).property("controller.hoursLeft")

    completed: (->
        "completed_" + @get("controller.completed")
    ).property("controller.completed")

    didInsertElement: (->
        text = document.querySelector("#task textarea")
        
        resize = ->
            onlyPlaceholder = false

            if text.value == ""
                text.value = text.placeholder
                onlyPlaceholder = true

            text.style.height = 'auto'; 
            text.style.height = text.scrollHeight+'px';

            if onlyPlaceholder
                text.value = "" 


        observe = (element, event, handler) ->
            element.addEventListener(event, handler, false);
      
        delayedResize = ->
            window.setTimeout(resize, 0);

        observe(text, 'change',  resize);
        observe(text, 'cut',     delayedResize);
        observe(text, 'paste',   delayedResize);
        observe(text, 'drop',    delayedResize);
        observe(text, 'keydown', delayedResize);
        observe(window, 'resize', delayedResize);

        delayedResize() unless @get("controller.completed")
    )