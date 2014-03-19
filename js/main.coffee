require ['Views/Global'],
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

	$.ajax "/regions/state", success: (res) ->
		if res > (localStorage[regionsVersion] or 0) 
			localStorage.clear()
			localStorage[regionsVersion] = res

	Backbone.history.start()
	return