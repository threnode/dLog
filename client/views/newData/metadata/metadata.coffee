
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
		category = event.target.id
		newDataFormState.CategoryDropdownText = 'Category: <strong>' + category + '</strong>'
		newDataFormState.ActivityDropdownText = 'Select an activity'
		newDataFormState.ActivityDropdownDisabled = false
		newDataFormState.ListofActivities = (Activities.find({'label':category}).fetch())[0].children
		newDataFormState.newmetaSummary.category = category
		Session.set 'newdataForm', newDataFormState
		#set cat value for new data log entry
		NewDLog.metadata.category = category
		

	#Select an activity from the dropdown
	'click .activity-selection' : (event) ->
		#set template vars
		activity = event.target.id
		newDataFormState.newmetaSummary.activity = activity
		newDataFormState.ActivityDropdownText = 'Activity: <strong>' + activity  + '</strong>'
		Session.set 'newdataForm', newDataFormState
		#set activity value for new data log entry
		NewDLog.metadata.activity = activity


	#Open modal to create new metadata cat/activty tag	
	'click .open-modal-to-add-new-meta-tag' : (event) ->
		#clone new meta ref object
		@newmeta = _.clone NewMetaData
		newmeta.type = event.target.dataset.newtype
		##set template vars
		newDataFormState.CreateNewMetaTagOfType = event.target.dataset.newtype
		#assemble modal header text
		if (event.target.dataset.newtype is 'activity')
			newHeader = '<strong>' + event.target.dataset.newtype + '</strong> to <strong class="cat">' + NewDLog.metadata.category + '</strong>'
		else
			newHeader = '<strong class="cat">' + event.target.dataset.newtype + '</strong>'
		newDataFormState.NewMetaTagModalHeaderText = newHeader
		Session.set 'newdataForm', newDataFormState



	#save new/updated meta data	
	'click #save-new-meta-data' : (event) ->
		newmeta.label = (this.find(settings.newMetaInputField)).val()
		newmeta.created = moment().format 'X'
		if newmeta.type isnt 'category' 
			delete newmeta.user
			delete newmeta.type
			newDataFormState.ActivityDropdownText = 'Activity: <strong>' + newmeta.label  + '</strong>'
			doc_to_update = Activities.findOne {label: NewDLog.metadata.category}
			Activities.update {_id: doc_to_update._id}, {$set: {lastupdated: newmeta.created}, $push: {children: newmeta}} 
			newDataFormState.ListofActivities = (Activities.find({'label':NewDLog.metadata.category}).fetch())[0].children
		else
			newmeta.user = Meteor.userId()
			delete newmeta.type
			newDataFormState.ActivityDropdownText = 'Select an activity'
			newDataFormState.ActivityDropdownDisabled = false
			NewDLog.metadata.category = newmeta.label
			newDataFormState.CategoryDropdownText = 'Category: <strong>' + newmeta.label + '</strong>'
			Activities.insert newmeta 
		delete newmeta
		$('#new-meta-data-modal').modal 'hide'
		Session.set 'newdataForm', newDataFormState
		$(this.find(settings.newMetaInputField)).val()

	'click #cancel-new-meta-data' : (event) ->
		delete newmeta
		$(this.find(settings.newMetaInputField)).val()


