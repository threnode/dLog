
Template.metadata.metacat = 
	-> (Session.get 'newdataForm').metacat
Template.metadata.metaact = 
	-> (Session.get 'newdataForm').metaact
Template.metadata.activity = 
	-> (Session.get 'newdataForm').activity
Template.metadata.activities = 
	-> (Session.get 'newdataForm').activities



#template variables
Template.metadata.helpers 
	meta: -> Activities.find()
	

    #event handler
Template.metadata.events =
	#meta dropdown selection
	'click .metacat' : (event) ->
		console.log event.target.id
		newDataFormState.metacat = 'Category: ' + event.target.id
		newDataFormState.activity = ''
		newDataFormState.activities = (Activities.find({'label':event.target.id}).fetch())[0].children
		console.log newDataFormState.activities
		Session.set 'newdataForm', newDataFormState
	'click .metaact' : (event) ->
		console.log event.target.id
		newDataFormState.metaact = 'Activity: ' + event.target.id
		Session.set 'newdataForm', newDataFormState
		console.log newDataFormState
		