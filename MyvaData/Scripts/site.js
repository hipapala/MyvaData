angular.module('myva', ['ngMaterial', 'ngRoute', 'ngResource', 'ngMessages', 'myvautilities'])
.config(function ($routeProvider) {
    $routeProvider
     .when('/Lists', {
         templateUrl: domain + 'Lists',
         controller: 'ListsCtrl'
     })
    .when('/ListEdit/:id', {
        templateUrl: domain + 'ListEdit',
        controller: 'ListEditCtrl'
    })
    .when('/List/:id', {
        templateUrl: domain + 'Lists',
        controller: 'ListCtrl'
    })
    .when('/ItemEdit/:listId/:id', {
        templateUrl: domain + 'ItemEdit',
        controller: 'ItemEditCtrl'
    })
    .when('/Items/:id', {
        templateUrl: domain + 'Items',
        controller: 'ItemsCtrl'
    })
    .when('/ItemNew/:listId', {
        templateUrl: domain + 'ItemEdit',
        controller: 'ItemEditCtrl'
    })
    .otherwise({
        redirectTo: '/Lists'
    });
})
.factory('apiList', function ($resource) {
    return $resource(domainApi + 'MvList');
})
.factory('apiField', function ($resource) {
    return $resource(domainApi + 'MvField', null, {
        'update': { method: 'PUT' }
    });
})
.factory('apiItem', function ($resource) {
    return $resource(domainApi + 'MvItem', null, {
        'update': { method: 'PUT' }
    });
})
.factory('apiOption', function ($resource) {
    return $resource(domainApi + 'MvOption', null, {
        'update': { method: 'PUT' }
    });
})
.controller('LoadCtrl', function ($rootScope, $scope) {
})
.controller('ItemEditCtrl', function ($rootScope, $routeParams, $scope, $location, apiItem, apiField, apiList) {
    apiList.get({ id: $routeParams.listId }, function (resp) {
        $scope.list = resp;
    });
    if ($routeParams.id) {
        apiItem.get({ id: $routeParams.id }, function (resp) {
            $scope.item = resp.Id ? { Id: resp.Id, Values: valuesToObject(parseValues(resp.Values)) } : { Values: {} };
        });
    } else {
        $scope.item = { Values: {} };
    }

    $scope.save = function () {
        if ($scope.mvForm.$valid) {
            var values = formatValues(objectToValues($scope.item.Values));
            if ($scope.item.Id) {
                apiItem.update({ id: $scope.item.Id }, { Values: values }, function (resp) {
                    if (resp.Id) {
                        alert('Successfully saved.');
                        $location.url("/Items/" + $routeParams.listId);
                    }
                });
            } else {
                apiItem.save({ listId: $routeParams.listId }, { Values: values }, function (resp) {
                    if (resp.Id) {
                        alert('Successfully saved.');
                        $location.url("/Items/" + $routeParams.listId);
                    }
                });
            }
        } else {
            alert('Fill all required fields.');
        }
    }

    $scope.cancel = function () {
        $location.url("/Items/" + $routeParams.listId);
    }
})
.controller('ItemsCtrl', function ($rootScope, $routeParams, $scope, $location, apiItem, apiList, $filter) {
    $scope.filter = { items: {} };
    $scope.id = $routeParams.id;
    var listPromise = apiList.get({ id: $routeParams.id, fieldsSingleValue: true });
    apiItem.query({ listValues: true, listId: $routeParams.id }, function (itemsResp) {
        listPromise.$promise.then(function (listResp) {
            $scope.list = listResp;
            $scope.allItems = $.map(itemsResp, function (item) {
                return { Id: item.Id, Values: valuesToObject(parseValues(item.Values)) };
            });
            $scope.items = $scope.allItems;
            $scope.$watch('filter', function (filter) {
                var items = $scope.allItems;
                var filterQuery = { Values: {} };
                if (filter.searchQuery) {
                    filterQuery.$ = filter.searchQuery;
                }
                if (filter.textItems) {
                    for (var filterItem in filter.textItems) {
                        if (filter.textItems[filterItem]) {
                            filterQuery.Values[filterItem] = { StringValue: filter.textItems[filterItem] };
                        }
                    }
                }
                if (filterQuery.$ || !$.isEmptyObject(filterQuery.Values)) {
                    items = $filter('filter')(items, filterQuery);
                }

                if (filter.selectItems) {
                    var selectFilterQuery = {};
                    for (var filterItem in filter.selectItems) {
                        if (filter.selectItems[filterItem] && filter.selectItems[filterItem].length > 0) {
                            selectFilterQuery[filterItem] = $.map(filter.selectItems[filterItem], function (filterOption) { return parseInt(filterOption); });
                        }
                    }
                    if (!$.isEmptyObject(selectFilterQuery)) {
                        items = jQuery.grep(items, function (item) {
                            for (var filterItem in selectFilterQuery) {
                                if (!item.Values[filterItem] || selectFilterQuery[filterItem].indexOf(item.Values[filterItem].OptionId) < 0)
                                    return false;
                            }
                            return true;
                        });
                    }
                }

                if (filter.dateItems) {
                    var dateFilterQuery = {};
                    for (var filterItem in filter.dateItems) {
                        if (filter.dateItems[filterItem] && filter.dateItems[filterItem].mainDate) {
                            dateFilterQuery[filterItem] = angular.copy(filter.dateItems[filterItem]);
                            if (!dateFilterQuery[filterItem].addDate && !dateFilterQuery[filterItem].infnt) {
                                dateFilterQuery[filterItem].addDate = moment(dateFilterQuery[filterItem].mainDate).add(1, 'day').toDate();
                            }
                        }
                    }
                    if (!$.isEmptyObject(dateFilterQuery)) {
                        items = $.grep(items, function (item) {
                            for (var filterItem in dateFilterQuery) {
                                if (!item.Values[filterItem] || (!dateFilterQuery[filterItem].infnt && (item.Values[filterItem].DateValue < dateFilterQuery[filterItem].mainDate || item.Values[filterItem].DateValue >= dateFilterQuery[filterItem].addDate))
                                    || (dateFilterQuery[filterItem].infnt > 0 && item.Values[filterItem].DateValue < dateFilterQuery[filterItem].mainDate)
                                    || (dateFilterQuery[filterItem].infnt < 0 && item.Values[filterItem].DateValue > dateFilterQuery[filterItem].mainDate))
                                    return false;
                            }
                            return true;
                        });
                    }
                }
                $scope.items = items;
            }, true);
        });

    });
    $scope.open = function (id) {
        $location.url("/ItemEdit/" + $scope.id + '/' + id);
    }
})
.controller('ListsCtrl', function ($rootScope, $scope, $location, apiList) {
    apiList.query(function (resp) {
        $scope.lists = resp;
    });
    $scope.open = function (id) {
        $location.url("/Items/" + id);
    }
    $scope.edit = function (id) {
        $location.url("/ListEdit/" + id);
    }
    $scope.new = function (id) {
        if (!$scope.loading && $scope.newlist.$valid) {
            $scope.loading = true;
            var item = { Title: $scope.title };
            apiList.save(item, function (resp) {
                $location.url("/ListEdit/" + resp.Id);
            });
        }
    }
})
.controller('ListEditCtrl', function ($scope, $routeParams, $timeout, $mdSidenav, $mdDialog, apiList, apiField, apiOption, $interval, $location) {
    var listId = $routeParams.id;
    $scope.project = {};
    function MvItem(format, order) {
        this.Info = { Format: format, Title: '', IsRequired: false, Order: order };
        this.Options = [];
    }
    MvItem.prototype.removeOption = function (option) {
        var item = this;
        var confirm = $mdDialog.confirm()
                  .title('Are you sure?')
                  .textContent('All related data also would be removed.')
                  .ok('OK')
                  .cancel('Cancel');
        $mdDialog.show(confirm).then(function () {
            option.$removed = true;
        });
    };
    MvItem.prototype.addOption = function () {
        if (this.$option) {
            this.Options.push({ Info: { Title: this.$option, Order: (this.Options.length > 0 ? this.Options[this.Options.length - 1].Info.Order : 0) + 1 } });
            this.$option = '';
        }
    };

    $scope.tabIndex = 0;
    $scope.add = function (format) {
        var item = new MvItem(format, ($scope.items.length > 0 ? $scope.items[$scope.items.length - 1].Info.Order : 0) + 1);
        $scope.items.push(item);
        $scope.select(item);
    }
    $scope.select = function (item) {
        $scope.current = item;
        $scope.tabIndex = 1;
    }
    $scope.sortUp = function (item) {
        var index = $scope.items.indexOf(item);
        if (index > 0) {
            $scope.items.splice(index, 1);
            $scope.items.splice(index - 1, 0, item);
            $scope.items[index].Info.Order = item.Info.Order;
            item.Info.Order = item.Info.Order - 1;
        }
    }
    $scope.sortDown = function (item) {
        var index = $scope.items.indexOf(item);
        if (index < $scope.items.length - 1) {
            $scope.items.splice(index, 1);
            $scope.items.splice(index + 1, 0, item);
            $scope.items[index].Info.Order = item.Info.Order;
            item.Info.Order = item.Info.Order + 1;
        }
    }
    $scope.remove = function () {
        var item = $scope.current;
        if (item.Id) {
            var confirm = $mdDialog.confirm()
                      .title('Are you sure?')
                      .textContent('All related data also would be removed.')
                      .ok('OK')
                      .cancel('Cancel');
            $mdDialog.show(confirm).then(function () {
                item.$removed = true;
                $scope.current = null;
            });
        }
    }

    $scope.removeList = function () {
        var confirm = $mdDialog.confirm()
                    .title('Are you sure?')
                    .textContent('All list data also would be removed.')
                    .ok('OK')
                    .cancel('Cancel');
        $mdDialog.show(confirm).then(function () {
            apiList.remove({ id: listId }, function () {
                $location.path('/Lists');
            });
        });
    }

    apiList.get({ id: listId }, function (resp) {
        $scope.list = { Id: resp.Id, Info: { Title: resp.Title }};
        $scope.list.$commit = angular.copy($scope.list.Info);

        $scope.items = $.map(resp.Fields, function (item) {
            var field = new MvItem(item.Format);
            field.Id = item.Id;
            field.Info.Title = item.Title;
            field.Info.IsRequired = item.IsRequired;
            field.Info.Order = item.Order;
            field.Options = $.map(item.Options, function (option) {
                var info = { Title: option.Title, Order: option.Order };
                return { Id: option.Id, Info: info, $commit: angular.copy(info) };
            });
            field.$commit = angular.copy(field.Info);
            return field;
        });


        function synchronize() {
            if (!angular.equals($scope.list.Info, $scope.list.$commit) && $scope.list.Info.Title) {
                $scope.list.$commit = angular.copy($scope.list.Info);
                apiList.save($.extend({Id: $scope.list.Id}, $scope.list.$commit));
            }
            $.each($scope.items, function (index, item) {
                {
                    if (!item.$commit && !item.Id) {
                        item.$commit = angular.copy(item.Info);
                        apiField.save({ listId: listId }, item.$commit, function (resp) {
                            item.Id = resp.Id;
                        });
                    } else if (item.Id && item.$commit && !item.$removed) {
                        if (!angular.equals(item.Info, item.$commit)) {
                            item.$commit = angular.copy(item.Info);
                            apiField.update({ id: item.Id }, item.$commit);
                        }
                        $.each(item.Options, function (index, option) {
                            if (!option.$commit && !option.Id) {
                                option.$commit = angular.copy(option.Info);
                                apiOption.save({ fieldId: item.Id }, option.$commit, function (resp) {
                                    option.Id = resp.Id;
                                });
                            } else if (option.$commit && option.Id && !option.$removed) {
                                if (!angular.equals(option.Info, option.$commit)) {
                                    option.$commit = angular.copy(option.Info);
                                    apiOption.update({ id: option.Id }, option.$commit, function (resp) {
                                        option.Id = resp.Id;
                                    });
                                }
                            } else if (option.$commit && option.Id && option.$removed) {
                                option.$commit = null;
                                apiOption.remove({ id: option.Id });
                            }
                        });
                    } else if (item.Id && item.$commit && item.$removed) {
                        item.$commit = null;
                        apiField.remove({ id: item.Id });
                    }
                }
            });
        }

        var interval = $interval(synchronize, 2000);
        $scope.$on('$destroy', function () {
            $interval.cancel(interval);
            $timeout(synchronize, 100);
        });
    });


    function debounce(func, wait, context) {
        var timer;
        return function debounced() {
            var context = $scope,
                args = Array.prototype.slice.call(arguments);
            $timeout.cancel(timer);
            timer = $timeout(function () {
                timer = undefined;
                func.apply(context, args);
            }, wait || 10);
        };
    }
    function buildDelayedToggler(navID) {
        return debounce(function () {
            $mdSidenav(navID)
              .toggle();
        }, 200);
    }
    function buildToggler(navID) {
        return function () {
            $mdSidenav(navID)
              .toggle();
        }
    }
    $scope.toggleLeft = buildDelayedToggler('left');
    $scope.close = function () {
        $mdSidenav('left').close();
    }
});