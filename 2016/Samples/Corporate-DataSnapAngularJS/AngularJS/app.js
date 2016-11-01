var app = angular.module('myApp', []);

app.controller('MainCtrl', function ($scope) {
    $scope.name = "Nick";
    $scope.receivers = [
        {value: 0.10},
        {value: 2000},
        {value: 4000},
        {value: 5000},
        {value: 7000}
    ];

    $scope.showSum = function () {
        var sumary = 0.00;
        angular.forEach($scope.receivers, function (obj, index) {
            sumary += parseFloat(obj.value);
        });
        //sumary = "" + sumary;
        //sumary = sumary.replace(/[.]/g, ",").replace(/\d(?=(?:\d{3})+(?:\D|$))/g, "$&.")
        return sumary;
    };
});

app.$inject = ['$scope'];


app.directive('format', ['$filter', function ($filter) {
    return {
        require: '?ngModel',
        link: function (scope, elem, attrs, ctrl) {
            if (!ctrl) return;


            ctrl.$formatters.unshift(function (a) {
                return $filter(attrs.format)(ctrl.$modelValue)
            });


            ctrl.$parsers.unshift(function (viewValue) {
                var plainNumber = viewValue.replace(/[^\d|\-+|\,+]/g, '');
                elem.val($filter(attrs.format)(plainNumber));
                return plainNumber;
            });
        }
    };
}]);