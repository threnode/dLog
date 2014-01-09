
Template.metadata.helpers
	meta: -> Activities.find() #Meta data collection
	CategoryDropdownText: -> (Session.get 'newdataForm').CategoryDropdownText
	ActivityDropdownText:  ->(Session.get 'newdataForm').ActivityDropdownText
	ActivityDropdownDisabled: -> (Session.get 'newdataForm').ActivityDropdownDisabled
	ListofActivities: -> (Session.get 'newdataForm').ListofActivities
	NewMetaTagModalHeaderText: -> (Session.get 'newdataForm').NewMetaTagModalHeaderText
	CreateNewMetaTagOfType: -> (Session.get 'newdataForm').CreateNewMetaTagOfType
	
settings = 
	newMetaInputField: '#new-meta-tag-input'


#event handlers
Template.metadata.events =
	
	#Select a category from the dropdown
	'click .category-selection ' : (event) ->
		#set template vars
		newDataFormState.category = event.target.id
		newDataFormState.CategoryDropdownText = 'Category: <strong>' + newDataFormState.category + '</strong>'
		newDataFormState.ActivityDropdownText = newDataFormStateDefaults.ActivityDropdownText
		newDataFormState.activity = undefined
		newDataFormState.ActivityDropdownDisabled = false
		newDataFormState.ListofActivities = (Activities.find({'label':newDataFormState.category}).fetch())[0].children
		Session.set 'newdataForm', newDataFormState

		

	#Select an activity from the dropdown
	'click .activity-selection' : (event) ->
		#set template vars
		newDataFormState.activity = event.target.id
		newDataFormState.ActivityDropdownText = 'Activity: <strong>' + newDataFormState.activity  + '</strong>'
		Session.set 'newdataForm', newDataFormState



	#Open modal to create new metadata cat/activty tag	
	'click .open-modal-to-add-new-meta-tag' : (event) ->
		#clone new meta ref object
		@newmeta = _.clone NewMetaData
		newmeta.type = event.target.dataset.newtype
		##set template vars
		newDataFormState.CreateNewMetaTagOfType = newmeta.type
		#assemble modal header text
		if (newmeta.type is 'activity')
			newHeader = '<strong>' + newmeta.type + '</strong> to <strong class="cat">' + newDataFormState.category + '</strong>'
		else
			newHeader = '<strong class="cat">' + newmeta.type + '</strong>'
		newDataFormState.NewMetaTagModalHeaderText = newHeader
		Session.set 'newdataForm', newDataFormState



	#save new/updated meta data	
	'click #save-new-meta-data' : (event, tmp) ->
		newmeta.label = ($ '#new-meta-tag-input').val()
		newmeta.created = moment().format 'X'
		if newmeta.type isnt 'category' 
			delete newmeta.type
			newDataFormState.ActivityDropdownText = 'Activity: <strong>' + newmeta.label  + '</strong>'
			doc_to_update = Activities.findOne {label: newDataFormState.category}
			Activities.update {_id: doc_to_update._id}, {$set: {lastupdated: newmeta.created}, $push: {children: newmeta}} 
			newDataFormState.ListofActivities = (Activities.find({'label':newDataFormState.category}).fetch())[0].children
			newDataFormState.activity = newmeta.label
		else
			newmeta.user = Meteor.userId()
			delete newmeta.type
			newDataFormState.ActivityDropdownText = newDataFormStateDefaults.ActivityDropdownText
			newDataFormState.ActivityDropdownDisabled = false
			NewDLog.metadata.category = newmeta.label
			newDataFormState.CategoryDropdownText = 'Category: <strong>' + newmeta.label + '</strong>'
			Activities.insert newmeta 
		delete newmeta
		$('#new-meta-data-modal').modal 'hide'
		Session.set 'newdataForm', newDataFormState
		($ '#new-meta-tag-input').val('')

	'click #cancel-new-meta-data' : (event) ->
		delete newmeta
		($ '#new-meta-tag-input').val('')


