# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

quiz = angular.module('quiz', [])

quiz.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

quiz.controller 'MainController', ($scope, $http) ->
	header = {'Accept': 'application/json'}
	form_data = {user: {name: "", email: ""}, user_answers: {}}
	
	$http 
		method: 'GET'
		url: '/questions'
		headers: header
	.then(
		((response)-> 
			$scope.questions = response.data
			
		)
		((response)-> 
			console.log response
		)	
	)
	
	$scope.submit = ->
		form_data["user"] = {"name": $scope.name, "email": $scope.email}
		
		$http 
			method: 'POST'
			url: '/user_answers'
			data: form_data
			headers: header
		.then(
			((response)-> 
				response.data
			
			)
			((response)-> 
				console.log response
			)	
		)
		
	$scope.select_answer = (question, answer)->
		form_data["user_answers"][question] = {"question": question, "answer": answer}
		console.log(form_data)
		
		
	return
	
	

		
		
		

