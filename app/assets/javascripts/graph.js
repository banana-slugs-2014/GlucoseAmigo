function graph(response) {

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
            categories: response.days
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
            shared: true
        },

        legend: {
            layout: 'vertical',
            align: 'left',
            x: 120,
            verticalAlign: 'top',
            y: 100,
            floating: true,
            backgroundColor: '#FFFFFF'
        },
        series: [{
            name: 'Weight',
            color: '#4572A7',
            type: 'spline',
            yAxis: 1,
            data: response.weight,
            tooltip: {
                valueSuffix: ' lbs'
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