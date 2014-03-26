function graph(response) {
    someVar = response.weight


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
            type: 'datetime',
            dateTimeLabelFormats: {
                day: '%b %e'
            },
            minPadding: 0,
            maxPadding: 0,
            startOnTick: true,
            startOfWeek: 1,
            labels: {
                step: 1
            },
            tickInterval: 24 * 3600 * 1000
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
                        color: '#606060'
                        // fontSize: '20px';
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
            data: someVar,
            pointStart: Date.UTC(response.year, response.month - 1, response.day),
            pointInterval: 8 * 3600 * 1000, // one day
            tooltip: {
                valueSuffix: ' lbs'
            }

        }, {
            name: 'Glucose',
            color: 'red',
            type: 'spline',
            data: response.glucose,
            pointStart: Date.UTC(response.year, response.month - 1, response.day),
            pointInterval: 8 * 3600 * 1000, // one day
            tooltip: {
                valueSuffix: 'mg/dL'
            }
        }]
    });
}