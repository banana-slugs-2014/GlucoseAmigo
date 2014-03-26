function graph(response) {
    console.log(response.days)

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
            // categories: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "sunday"],
            // categories: response.days,
            // type: 'datetime',
            // labels: {
            //     formatter: function() {
            //         return Highcharts.dateFormat('%a %e %b', this.value);
            //     }
            // }

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
            // pointInterval: 24 * 3600 * 1000,
            // pointStart: Date.UTC(2014, 0, 01),
            data: response.weight,
            pointStart: Date.UTC(response.year, response.month - 1, response.day),
            pointInterval: 8 * 3600 * 1000, // one day
            tooltip: {
                valueSuffix: ' lbs'
            }

        }, {
            name: 'Glucose',
            color: 'red',
            type: 'spline',
            // pointInterval: 24 * 3600 * 1000,
            // pointStart: Date.UTC(2014, 0, 01),
            data: response.glucose,
            pointStart: Date.UTC(response.year, response.month - 1, response.day),
            pointInterval: 8 * 3600 * 1000, // one day
            tooltip: {
                valueSuffix: 'mg/dL'
            }
        }]
    });
}