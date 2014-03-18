return require ['Views/Global'],
(GlobalView) ->
	app = {
	}

	app.Router = Backbone.Router.extend {
	  routes: {
	    "*default":          "default"
	  }

	  default: ->
	  	app.GlobalView = new GlobalView({el: $('body')})
	}
	
	router = new app.Router

	Backbone.history.start()
	return