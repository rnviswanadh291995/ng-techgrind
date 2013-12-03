(function() {

	var appModule = angular.module('TechGrindApp.plugins.menu.accordion', []);

	appModule.controller('MenuAccordionCtrl', ['$scope', function($scope) {

		$scope.groups = listOfCategories;
		
		
	}]);
}).call(this);

var listOfCategories = [
		{
			'title' : 'Architectural patterns',
			'id' : '0',
			'content' : 'An architectural pattern is a standard design in the field of software architecture. The concept of an architectural pattern has a broader scope than the concept of design pattern. The architectural patterns address various issues in software engineering, such as computer hardware performance limitations, high availability and minimization of a business risk. Some architectural patterns have been implemented within software frameworks.',
			'items' : [{
				id : '0',
				name : 'first'
			}, {
				id : '1',
				name : 'second'
			}, {
				id : '2',
				name : 'last'
			}]

		}, {
			'title' : 'Seed Round',
			'id' : '1',
			'content' : 'Cras orci turpis, interdum vitae felis volutpat, viverra malesuada nunc. Fusce magna dolor, ',
			'items' : [{
				id : '3',
				name : '3'
			}, {
				id : '4',
				name : '4'
			}, {
				id : '5',
				name : '5'
			}]
		}, {
			'title' : 'Investors',
			'id' : '2',
			'content' : 'Cras orci turpis, interdum vitae felis volutpat, viverra malesuada nunc. Fusce magna dolor, ',
			'items' : [{
				id : '6',
				name : 'six'
			}, {
				id : '7',
				name : 'seven'
			}, {
				id : '8',
				name : 'eight'
			}]
		}, {
			'title' : 'Plans',
			'id' : '3',
			'content' : 'Cras orci turpis, interdum vitae felis volutpat, viverra malesuada nunc. Fusce magna dolor, ',
			'items' : [{
				id : '9',
				name : 'first'
			}, {
				id : '10',
				name : 'second'
			}, {
				id : '11',
				name : 'last'
			}]
		}, {
			'title' : 'Budget',
			'id' : '4',
			'content' : 'Cras orci turpis, interdum vitae felis volutpat, viverra malesuada nunc. Fusce magna dolor, ',
			'items' : [{
				id : '12',
				name : 'first'
			}, {
				id : '13',
				name : 'second'
			}, {
				id : '14',
				name : 'last'
			}]
		}, {
			'title' : 'Offices',
			'id' : '5',
			'content' : 'Cras orci turpis, interdum vitae felis volutpat, viverra malesuada nunc. Fusce magna dolor, ',
			'items' : [{
				id : '15',
				name : 'first'
			}, {
				id : '16',
				name : 'second'
			}, {
				id : '17',
				name : 'last'
			}]
		}, {
			'title' : 'Hiring',
			'id' : '6',
			'content' : 'Cras orci turpis, interdum vitae felis volutpat, viverra malesuada nunc. Fusce magna dolor, ',
			'items' : [{
				id : '18',
				name : 'first'
			}, {
				id : '19',
				name : 'second'
			}, {
				id : '20',
				name : 'last'
			}]
		}, ];