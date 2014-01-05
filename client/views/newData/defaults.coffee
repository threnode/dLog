#object model for Metadata collection
@NewMetaData =
	label: null
	children: []
	weight: null
	created: null
	lastupdated: null
	user: null

#object model for Activity collection
@NewDLog =
	logInfo :
		user: null
		inputTime: null
		inputLocation:
			exists: false
			latitude: null
			longitude: null
	timedata:
		timetype: 'length'
		length: null
		strtime: null
		endtime: null
	datedata: null
	metadata:
		category: null
		activity: null


#New Log form state tracking and defaults
@newDataFormState =
	newmetaSummary:
		duration: '0 mins'
		timechoice: 'length'
		datechoice: 'today'
		verbosedate: moment().format "dddd, MMMM Do YYYY"
		shortdate:  moment().format "MM-DD-YYYY"
	CategoryDropdownText: 'Select a catagory'
	ActivityDropdownText: 'Select an activity'
	ActivityDropdownDisabled: true
	timechoice: 
		duration: 1
		actual: 0
		simple: 0
	datechoice : 
		today: 1
		yesterday: 0
		selectdate: 0
	setup: true
#set defaults
Session.set 'newdataForm', newDataFormState