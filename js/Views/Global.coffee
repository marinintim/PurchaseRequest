define "Views/Global",
['Views/Form','Views/Summary','Models/PurchaseRequest'],
(FormView, SummaryView, PurchaseRequest) -> 
	GlobalView = Backbone.View.extend {
		initialize: ->
			this.model = new PurchaseRequest
			this.formView = new FormView {model: this.model}
			this.summaryView = new SummaryView {model: this.model}
			this.render()
			return

		render: ->
			this.formView.render()
			this.summaryView.render()
			return
	}
