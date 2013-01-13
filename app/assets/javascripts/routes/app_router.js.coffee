FF.Router = Ember.Router.extend
  location: 'hash'

  root: Ember.Route.extend
    welcome: Ember.Route.extend
      route: '/'

      createDoTask: (router) ->
        task = FF.DoTask.createRecord()
        @_createTask(router,task)

      createDontTask: (router) ->
        task = FF.DontTask.createRecord()
        @_createTask(router,task)

      gotoHistory: Ember.Router.transitionTo('history')

      _createTask: (router,task) ->
        router.get("store").commit();
        router.get("applicationController").set("content",task)
        unless  Em.none( _gaq )
          _gaq.push(['_trackEvent', 'Task', 'Created', task.get("task_type")]);
        router.transitionTo('task')
        
      connectOutlets: (router) ->
        router.get("applicationController").connectOutlet("Welcome")
      
      
    task: Ember.Route.extend

      enter: (router) ->
        task = FF.Task.findActive()
        @set "task", task
        router.get("applicationController").set("content",task)
        router.get("applicationController").startTicking()

      completeTask: (router) ->
        @get("task").complete( true )
        router.get("store").commit()

      rejectTask: (router) ->
        @get("task").complete( false )
        router.get("store").commit()

      confirmTask: (router) ->
        @get("task").start()
        router.get("store").commit()

      startAgain: (router) ->
        router.transitionTo('welcome')

      gotoHistory: Ember.Router.transitionTo('history')

      connectOutlets: (router) ->
        router.get("applicationController").connectOutlet("Task")

    history: Ember.Route.extend

      gotoWelcome: (router) ->
        unless FF.Task.findActive
          router.transitionTo('welcome')
        else
          router.transitionTo('task')

      nextMonth: (router) ->
        router.get("historyController").nextMonth()

      prevMonth: (router) ->
        router.get("historyController").prevMonth()

      selectTask: (router, context) ->
        router.get("historyController").selectTask(context)

      reuseTask: (router,context) ->
        router.get("historyController").reuseTask(context)         

      connectOutlets: (router) ->
        router.get("applicationController").connectOutlet("history")