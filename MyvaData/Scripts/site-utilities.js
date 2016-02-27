function valuesToObject(values) {
    var obj = {};
    $.each(values, function (index, value) {
        if (obj[value.FieldId] && value.OptionId) {
            //For multiple values
            if (!$.isArray(obj[value.FieldId].OptionId)) {
                obj[value.FieldId].OptionId = [obj[value.FieldId].OptionId];
                obj[value.FieldId].$OptionKey = {};
                obj[value.FieldId].$OptionKey[obj[value.FieldId].OptionId] = obj[value.FieldId].Id;
            }
            obj[value.FieldId].OptionId.push(value.OptionId);
            obj[value.FieldId].$OptionKey[value.OptionId] = value.Id;
        } else {
            obj[value.FieldId] = value;
        }
    });
    return obj;
}
function objectToValues(obj) {
    var values = [];
    $.each(obj, function (key, value) {
        if ($.isArray(value.OptionId)) {
            $.each(value.OptionId, function (OptionKey, OptionValue) {
                values.push({ Id: value.$OptionKey ? value.$OptionKey[OptionValue] : 0, FieldId: key, StringValue: value.StringValue, IntValue: value.IntValue, DateValue: value.DateValue, OptionId: OptionValue });
            });
        } else {
            values.push({ Id: value.Id, FieldId: key, StringValue: value.StringValue, IntValue: value.IntValue, DateValue: value.DateValue, OptionId: value.OptionId });
        }
    });
    return values;
}
function formatValues(values) {
    var fValues = [];
    $.each(values, function (index, value) {
        fValues.push({ Id: value.Id, FieldId: value.FieldId, StringValue: value.StringValue, IntValue: value.IntValue, DateValue: value.DateValue ? moment(value.DateValue).format('YYYY-MM-DDTHH:mm:ss') : null, OptionId: value.OptionId });
    });
    return fValues;
}
function parseValues(values) {
    var pValues = [];
    $.each(values, function (index, value) {
        pValues.push({ Id: value.Id, FieldId: value.FieldId, StringValue: value.StringValue, IntValue: value.IntValue, DateValue: value.DateValue ? moment(value.DateValue).toDate() : null, OptionId: value.OptionId, OptionTitle: value.OptionTitle });
    });
    return pValues;
}
angular.module('myvautilities', [])
.directive('mvDatefilter', function ($mdDialog, $timeout) {
    return {
        require: '?ngModel',
        link: function (scope, element, attr, ngModelCtrl) {
            element.next('md-datepicker').find('.md-datepicker-button').hide();
            element.append();
            scope.$watch(attr.ngModel, function (value) {
                if (value) {
                    var icon = element.find('md-icon');
                    var title = $('<span class="mv-filtertitle" style="display:none"></span>');
                    element.find('.mv-filtertitle').remove();
                    if (value.mainDate && value.addDate) {
                        var duration = moment(value.addDate).diff(moment(value.mainDate), 'days');
                        element.append('<span class="mv-filtertitle" ' + (duration > 0 ? '' : 'style="color:red"') + ' >' + (duration > 0 ? '+' + duration : '0') + '</span>');
                        icon.hide();
                    } else if (value.mainDate && (value.infnt > 0 || value.infnt < 0)) {
                        element.append('<span class="mv-filtertitle">' + (value.infnt > 0 ? '+' : '-') + '</span>');
                        icon.hide();
                    } else {
                        icon.show();
                    }
                }
            }, true);
            element.on('click', function () {
                $mdDialog.show({
                    parent: angular.element(document.body),
                    template:
                      '<md-dialog aria-label="List dialog" class="mv-date-modal">' +
                      '  <md-dialog-content>' +
                      '    <md-list>' +
                      '      <md-list-item>' +
                      '       <md-button flex ng-click="today()">Today</md-button>' +
                      '    </md-list-item>' +
                      '      <md-list-item>' +
                      '       <md-button flex ng-click="yesterday()">Yesterday</md-button>' +
                      '    </md-list-item>' +
                      '      <md-list-item>' +
                      '       <md-button flex ng-click="thisweek()">This week</md-button>' +
                      '    </md-list-item>' +
                      '      <md-list-item>' +
                      '       <md-button flex ng-click="previousweek()">Previous week</md-button>' +
                      '    </md-list-item>' +
                      '      <md-list-item>' +
                      '       <md-button flex ng-click="thismonth()">This month</md-button>' +
                      '    </md-list-item>' +
                      '      <md-list-item>' +
                      '       <md-button flex ng-click="previousmonth()">Previous month</md-button>' +
                      '    </md-list-item>' +
                      '      <md-list-item>' +
                      '       <md-datepicker ng-model="from" md-placeholder="From..."></md-datepicker><md-datepicker ng-model="to" md-placeholder="Until..."></md-datepicker>' +
                      '    </md-list-item>' +
                      '      <md-list-item>' +
                      '       <md-button flex ng-click="clear()">Clear</md-button>' +
                      '    </md-list-item>' +
                      '</md-list>' +
                      '  </md-dialog-content>' +
                      '  <md-dialog-actions>' +
                      '    <md-button ng-click="ok()" class="md-primary">' +
                      '      OK' +
                      '    </md-button>' +
                      '    <md-button ng-click="close()" class="md-primary">' +
                      '      Close' +
                      '    </md-button>' +
                      '  </md-dialog-actions>' +
                      '</md-dialog>',
                    controller: DialogController
                });
                function DialogController($scope, $mdDialog) {
                    var dt = ngModelCtrl.$viewValue;
                    if (dt && dt.mainDate) {
                        if (dt.addDate) {
                            $scope.from = dt.mainDate;
                            $scope.to = dt.addDate;
                        } else if (dt.infnt > 0) {
                            $scope.from = dt.mainDate;
                        } else if (dt.infnt < 0) {
                            $scope.to = dt.mainDate;
                        }
                    }

                    $scope.close = function () {
                        $mdDialog.hide();
                    }
                    $scope.ok = function () {
                        var dt = {};
                        if ($scope.from && $scope.to) {
                            dt.mainDate = $scope.from;
                            //  var duration = moment($scope.to).diff(moment($scope.from), 'days');
                            dt.addDate = $scope.to;
                        } else if ($scope.from) {
                            dt.mainDate = $scope.from;
                            dt.infnt = 1;
                        } else if ($scope.to) {
                            dt.mainDate = $scope.to;
                            dt.infnt = -1;
                        }
                        ngModelCtrl.$setViewValue(dt);
                        $mdDialog.hide();
                    }
                    $scope.today = function () {
                        var td = moment();
                        $scope.from = td.toDate();
                        $scope.to = moment(td).add(1, 'day').toDate();
                        $scope.ok();
                    }
                    $scope.yesterday = function () {
                        var td = moment().subtract(1, 'day');
                        $scope.from = td.toDate();
                        $scope.to = moment(td).add(1, 'day').toDate();
                        $scope.ok();
                    }
                    $scope.thisweek = function () {
                        var td = moment();
                        $scope.from = td.startOf('week').toDate();
                        $scope.to = moment($scope.from).add(7, 'day').toDate();
                        $scope.ok();
                    }
                    $scope.previousweek = function () {
                        var td = moment().subtract(7, 'day');
                        $scope.from = td.startOf('week').toDate();
                        $scope.to = moment($scope.from).add(7, 'day').toDate();
                        $scope.ok();
                    }
                    $scope.thismonth = function () {
                        var td = moment();
                        $scope.from = td.startOf('month').toDate();
                        $scope.to = moment($scope.from).add(1, 'month').toDate();
                        $scope.ok();
                    }
                    $scope.previousmonth = function () {
                        var td = moment().subtract(1, 'month');
                        $scope.from = td.startOf('month').toDate();
                        $scope.to = moment($scope.from).add(1, 'month').toDate();
                        $scope.ok();
                    }
                    $scope.clear = function () {
                        $scope.from = null;
                        $scope.to = null;
                        $scope.ok();
                    }
                }
            });
        }

    };
});
//.factory('$mvFilter', ["$mdDialog", "$rootScope", function ($mdDialog, $rootScope) {
//    return {
//        setFilter: function (dt) {
//            var parentEl = angular.element(document.body);
//            $mdDialog.show({
//                parent: parentEl,
//                template:
//                  '<md-dialog aria-label="List dialog">' +
//                  '  <md-dialog-content>' +
//                  '    <md-list>' +
//                  '      <md-list-item ng-repeat="item in items">' +
//                  '       <p>Number {{item}}</p>' +
//                  '      ' +
//                  '    </md-list-item></md-list>' +
//                  '  </md-dialog-content>' +
//                  '  <md-dialog-actions>' +
//                  '<md-datepicker ng-model="myDate" md-placeholder="Enter date"></md-datepicker>' +
//                  '    <md-button ng-click="closeDialog()" class="md-primary">' +
//                  '      Close Dialog' +
//                  '    </md-button>' +
//                  '  </md-dialog-actions>' +
//                  '</md-dialog>',
//                controller: DialogController
//            });
//            function DialogController($scope, $mdDialog) {
//                //  $scope.items = items;
//                $scope.closeDialog = function () {
//                    alert($scope.myDate);
//                    $mdDialog.hide();
//                }
//            }
//        }
//    };
//}])