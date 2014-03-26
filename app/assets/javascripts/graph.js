function graph(response) {
<<<<<<< HEAD
    console.log(response.glucose)
=======
    someVar = response.weight

>>>>>>> working graph with customized x axis
    $('#graph').highcharts({
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: 'Weekly Glucose and Weight'
        },
        subtitle: {
            text: response.diabetic.name
        },
        xAxis: [{
            categories: response.days,
            labels: {
                step: step_det(response)
                // step: step_det(response);
            },
            // mintickInterval: 2
        }],
        yAxis: [{ // Primary yAxis
            labels: {
                format: '{value}mg/dL',
                style: {
                    color: 'red'
                }
            },
            title: {
                text: 'Glucose',
                style: {
                    color: 'red'
                }
            },
            min: 0,
            minorGridLineWidth: 0,
            gridLineWidth: 0,
            alternateGridColor: null,
            plotBands: [{
                from: 70.0,
                to: 130.0,
                color: 'lightblue',
                label: {
                    text: 'Normal Glucose Levels',
                    style: {
                        color: '#606060',
                    }
                }

            }],
        }, { // Secondary yAxis
            title: {
                text: 'Weight',
                style: {
                    color: '#4572A7'
                }
            },
            labels: {
                format: '{value} lbs',
                style: {
                    color: '#4572A7'
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true,

        },

        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -150,
            y: 100,
            floating: true,
            borderWidth: 1,
            backgroundColor: '#FFFFFF'
        },
        series: [{
            name: 'Weight',
            color: '#4572A7',
            type: 'spline',
            yAxis: 1,
<<<<<<< HEAD
            data: response.weight,
            pointStart: Date.UTC(response.year, response.month - 1, response.day),
            pointInterval: 8 * 3600 * 1000, // one day
=======
            data: someVar,
>>>>>>> working graph with UTC code
            tooltip: {
                valueSuffix: ' lbs',
                formatter: function() {
                    return this.x
                }
            }

        }, {
            name: 'Glucose',
            color: 'red',
            type: 'spline',
            data: response.glucose,
            tooltip: {
                valueSuffix: 'mg/dL'
            }
        }]
    });
}

function step_det(response) {
    if (response.num_of_days <= 2) {
        console.log('yo')
        return 1;
    } else if (2 < response.num_of_days && response.num_of_days < 5) {
        return 2;
    } else {
        return 3;
    }
}