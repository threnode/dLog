// Template.hello.greeting = function () {
//     return "dLog personal data trackingmetoer ";
//   };

//   Template.hello.events({
//     'click input' : function () {
//       // template data, if any, is available in 'this'
//       if (typeof console !== 'undefined')
//         console.log("You pressed the button");
//     }
//   });
$(function(){
	$('.single-login-button, .login-button').addClass('btn btn-primary btn-sm');
});


Template.addquestion.events({
    'click input.add-item' : function(event){
        event.preventDefault();
        var questionText = document.getElementById("questionText").value;
        Meteor.call("addQuestion",questionText,function(error , questionId){
          console.log('added question with Id .. '+questionId);
        });
        document.getElementById("questionText").value = "";
 
    }
});