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
	$scope.current_question_index = 0
	$scope.current_question_id = 0
	$scope.show_submit = false
	$scope.show_contact = false
	
	$http 
		method: 'GET'
		url: '/questions'
		headers: header
	.then(
		((response)-> 
			$scope.questions = response.data
			$scope.current_question_id = $scope.questions[$scope.current_question_index].id
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
					window.location = '/users/' + response.data.id + '/user_answers/'
			
				)
				((response)-> 
					console.log response
				)	
			)
		
	$scope.select_answer = (question, answer)->
		form_data["user_answers"][question] = {"question": question, "answer": answer}
		console.log(form_data)
	
	$scope.next = ->
		if $scope.current_question_index == $scope.questions.length - 1
			$scope.show_submit = true
			$scope.show_contact = true	
		else
			if(form_data["user_answers"][$scope.current_question_id] == undefined)
				$scope.errors.push "Please answer the question"
			else
				$scope.errors = []
				$scope.current_question_id = $scope.questions[++$scope.current_question_index].id
		
		
		
		console.log($scope.current_question_id)
	
	
	validate_answer = (question) ->
		if !form_data["user_answers"].hasOwnProperty(question.id)
			$scope.errors.push "Please answer question '" + question.question + "'"
		
		
	return
	
quiz.controller 'CompleteController', ($scope, $http) ->
	header = {'Accept': 'application/json'}
		
		
	return

		
		
		

