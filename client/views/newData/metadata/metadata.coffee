
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
		newDataFormState.metacat = 'Category: ' + event.target.id
		newDataFormState.metaact = 'Select an activity'
		newDataFormState.activity = ''
		newDataFormState.activities = (Activities.find({'label':event.target.id}).fetch())[0].children
		Session.set 'newdataForm', newDataFormState
		NewDLog.metadata.category = event.target.id
	'click .metaact' : (event) ->
		newDataFormState.metaact = 'Activity: ' + event.target.id
		Session.set 'newdataForm', newDataFormState
		NewDLog.metadata.activity = event.target.id
	'click .newmetabtn' : (event) ->
		console.log newDataFormState
		console.log event.target.dataset.newtype
		