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
	$scope.errors = []
	
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
		
		$scope.errors = []
		if $scope.name == undefined
			$scope.errors.push "Please enter a name"
		if $scope.email == undefined
			$scope.errors.push "Please enter an e-mail address"
			
		validate_answer question for question in $scope.questions
		
		if $scope.errors.length
			console.log "errors"
		else		
			$http 
				method: 'POST'
				url: '/user_answers'
				data: form_data
				headers: header
			.then(
				((response)-> 
					console.log response.data
					window.location = '/users/' + response.data.id + '/user_answers/'
			
				)
				((response)-> 
					console.log response
				)	
			)
		
	$scope.select_answer = (question, answer)->
		form_data["user_answers"][question] = {"question": question, "answer": answer}
		console.log(form_data)
		
	validate_answer = (question) ->
		if !form_data["user_answers"].hasOwnProperty(question.id)
			$scope.errors.push "Please answer question '" + question.question + "'"
		
		
	return
	
quiz.controller 'CompleteController', ($scope, $http) ->
	header = {'Accept': 'application/json'}
		
		
	return

		
		
		

