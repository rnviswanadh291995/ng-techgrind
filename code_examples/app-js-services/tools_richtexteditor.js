(function() {
	var app = angular.module('ToolsRichEditor', [ 'ui.bootstrap','TechGrindApp.directives.ui.tinymce' ]);
	app.service('ToolsRichEditorService',
		['$modal', 'steam', '$rootScope', '$http',
		 function($modal, steam, $rootScope, $http) {

			var self = this;
			self.isOpen = false;
			self.isLogged = false;
			self.user = steam.loginp();
			self.loginp = steam.loginp;
			self.tinymceOptions = {
					selector : "#inputContentRichText",
					plugins : [
							"advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",
							"searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
							"save table contextmenu directionality emoticons template paste textcolor" ],
					width : '100%',
					height : 310,
					browser_spellcheck : true,
					statusbar : false,
					menubar : false,
					paste_as_text : true,
					toolbar : "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | link image media | bullist | forecolor backcolor",
					charLimit : 1000000, // this is a
										// default
										// value
										// which can
										// get
										// modified
										// later
				};

			self.tinymce = 'Write your own article, news, or tutorial and publish it now!';
			self.labels = '';
			//self.dialogCategories = ['news','guides','tutorials'];
			self.dialogCategories = [];

			listOfCatFromJson = $http.get('http://dev-back1.techgrind.asia/scripts/rest.pike?request=/home/techgrind/resources/guides/tree');

			self.location = [];
			listOfCatFromJson.success(function(data){
				console.log('Data for menu...', data.inventory);
				$.each(data.inventory, function(k0, v0){
					self.location.push(v0.name);
					$.each(v0.inventory, function(k1, v1){
						self.location.push('::::'+v1.name);
						$.each(v1.inventory, function(k2, v2){
							self.location.push('::::::::'+v2.name);
						});
					});
				});
			});
			
			var user = null;

			this.open = function(startCat) {
				console.log('Starting Category: ', startCat);
				if(!self.isOpen){
					if(!!!startCat){
						self.startCat = "news";
					}else{
						self.startCat = startCat;
					}
					
					if(self.startCat == "news"){
						self.dialogCategories = ['news'];
					}else{
						self.dialogCategories = ['guides','tutorials'];
					}
					self.isOpen = true;
					// lets check if the user is logged
					self.user = steam.loginp();
					self.loginp = steam.loginp;
	
					//open main modal window
					var modalInstance = $modal.open({
						backdrop : false,
						keyboard : false,
						backdropClick : true,
						dialogFade : true,
						templateUrl : 'partials/services/tools_richeditor.html',
						controller : ModalInstanceCtrl,
						windowClass : 'modal myWindow',
						resolve : {//We need to pass this values from scope into modal has required by Angular-UI
							dialogCategories : function() {
								return self.dialogCategories;
							},
							locations : function(){
								return self.location;
							},
							user : function() {
								return self.user;
							},
							loginp : function() {
								return self.loginp;
							},
							tinymce : function() {
								return self.tinymce;
							},
							tinymceOptions : function() {
								return self.tinymceOptions;
							},
							labels : function() {
								return self.labels;
							},
							initCat : function() {
								return self.startCat;
							}
						}
					});
					modalInstance.result.then(function (selectedItem) {
						console.log('Modal dismissed at: ' + new Date());
						self.isOpen = false;
					});
					modalInstance.opened.then(function (selectedItem) {
						console.log('modal opened');
					});
				}
			};
			var ModalInstanceCtrl = function($scope,$modalInstance, dialogCategories, locations, user, loginp, tinymce, tinymceOptions, labels,initCat) {
				$scope.dialogCategories = dialogCategories;
				$scope.selectedCategory = initCat;
//				$scope.initCat = function() {
//					return $scope.selectedCategory;
//				}
				$scope.initCat = $scope.selectedCategory;

				$scope.user = user;
				$scope.loginp = loginp;
				$scope.tinymceOptions = tinymceOptions;
				$scope.tinymce = tinymce;
				$scope.labels = labels;
				$scope.locations = locations;
				$scope.selectedLocation = locations[0];

				$scope.close = function(result) {
					try{
						$modalInstance.close();
					} catch(e){
						console.warn('Update bootstrap librarie to get ride of the error');
					}
				};
				$scope.login = function(result) {
					console.log('Trying to login...');
					$rootScope.openlogin = true;
				};
				$scope.save = function(result) {
					var jsonMsg = {
						title : this.title,
						fullText : this.tinymce,
						labels : this.labels,
						category : this.selectedCategory
					};
					// lets steam the information
					steam.put('news', jsonMsg).then(function() {
						console.log('Steam put.....');
					});
				};
				$scope.post = function() {
					var jsonMsg = {
						title : this.title,
						fullText : this.tinymce,
						labels : this.labels,
						category : this.selectedCategory
					};

					// lets steam the information
					steam.post('news', jsonMsg).then(function() {
						console.log('Steam post.....');
						try{
							$modalInstance.close();
						} catch(e){
							console.warn('Update bootstrap librarie to get ride of the error');
						}
					});
				};
				
				
			};
		}]);
}).call(this);