define "Views/Global",
['Views/Form','Views/Summary','Views/Error', 'Models/PurchaseRequest'],
(FormView, SummaryView, ErrorView, PurchaseRequest) -> 
	GlobalView = Backbone.View.extend {
		events:
			"click .pr-send": "send"
		initialize: ->
			@model = new PurchaseRequest
			@formView = new FormView model: @model
			@summaryView = new SummaryView model: @model
			@errorView = new ErrorView model: @model
			@listenTo @model, "invalid", @error
			return

		send: ->
			@errorView.unrender()
			@model.save({},{success:@redirect,error:@error})

		error: (model,response)->
			if model.validationError? then error = response
			if response.responseJSON?.error? then error = response.responseJSON.error 

			if response.status? and response.status == 500 then $('.pr-send').attr('disabled','disabled')
			@errorView.render(error)
			return

		redirect: (model,response) ->
			window.location.replace(response.redirect_url.toString()) 
			return

		render: ->
			@formView.render()
			@summaryView.render()
			return
	}
