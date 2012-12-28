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

      _createTask: (router,task) ->
        router.get("store").commit();
        router.get("applicationController").set("content",task)
        router.transitionTo('task')
        
      connectOutlets: (router) ->
        router.get("applicationController").connectOutlet("Welcome")
      
      
    task: Ember.Route.extend

      enter: (router) ->
        @set "task", router.get("applicationController").get("content")
        router.get("applicationController").connectControllers("window")

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

      connectOutlets: (router) ->
        router.get("applicationController").connectOutlet("Task")
