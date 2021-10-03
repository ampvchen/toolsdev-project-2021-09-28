# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('ul#location-dropdown li').click ->
    event.preventDefault()
    $('button#location-selected').text($(this).text().trim())

  setInterval () ->
    updateChartWeatherData()
  , 60 * 1000

  # Load weather
  loc = { name: $('#location-selected').text() }
  # Highcharts.getJSON '/temperatures.json', (data) ->
  Highcharts.setOptions
    exporting: false
    chart: height: 500
    xAxis: tickInterval: (((1000 * 60) * 60) * 24)
    lang:
      rangeSelectorFrom: 'From'
      rangeSelectorTo: 'To'
    rangeSelector:
      buttonTheme:
        fill: 'none'
        stroke: 'none'
        'stroke-width': 0
        r: 4
        style:
          color: 'gray'
          fontWeight: 'normal'
        states:
          # hover: {}
          select:
            fill: '#0D52FF'
            style: color: 'white'
            # disabled: { ... }
      buttons: [
        {
          type: 'day'
          count: 1
          text: 'Cd'
          events:
            click: ->
              console.log("CLICK")
              chartWeather.update({})
        },{
          type: 'day'
          count: 1
          text: '1d'
        },{
          type: 'week'
          count: 1
          text: '1w'
        }, {
          type: 'month'
          count: 1
          text: '1m'
        },{
          type: 'all'
          text: 'All'
        }
      ]

      inputBoxBorderColor: 'transparent',
      # inputBoxWidth: 120,
      # inputBoxHeight: 18,
      inputStyle:
        color: '#0D52FF'
        fontWeight: 'bold'
      labelStyle:
        color: 'gray'
        fontWeight: 'bold'

    responsive: rules: [{
      condition:
        maxWidth: 500
      chartOptions:
        chart: height: 400
        subtitle: text: null
        navigator: enabled: false
    }]

  chartWeather = Highcharts.stockChart 'chart-weather',
    legend: enabled: true
    title:
      text: "Weather for <b>#{loc.name}</b>"
    series: [{
      name: 'Historical'
      type: 'spline'
      showInNavigator: true
      tooltip: {
        valueDecimals: 0
      }
    }, {
      name: 'Forecast'
      type: 'spline'
      showInNavigator: true
      tooltop: {
        valueDecimals: 0
      }
    }]

  chartHighLow = Highcharts.stockChart 'chart-high-low',
    legend:  enabled: true
    title:
      text: "3-Hour Highs and Lows"

    series: [{
      name: 'High'
      type: 'spline'
      showInNavigator: true
      tooltip: {
        valueDecimals: 0
      }
    }, {
      name: 'Low'
      type: 'spline'
      showInNavigator: true
      tooltip: {
        valueDecimals: 0
      }
    }]

  updateChartWeatherData = () ->
   $.get "/locations/1/temperatures/forecast", (data) ->
     chartWeather.series[1].setData(data)

  setChartWeatherData = () ->
    $('#loading-chart-weather').removeClass("visually-hidden")

    $.get "/locations/1/temperatures/forecast", (data) ->
      chartWeather.series[1].setData(data)
      # Force reload to fix range position
      # TODO: Change to only run on init
      chartWeather.update({rangeSelector: { selected: 3 }})
      # $('#loading-chart-weather').addClass("visually-hidden")

    $.get "/locations/1/temperatures", (data) ->
      chartWeather.series[0].setData(data)
      chartWeather.update({rangeSelector: { selected: 3 }})

  setChartHighLowData = () ->
    $.get "/locations/1/temperatures/high_low", (data) ->
      chartHighLow.series[0].setData(data[0])
      chartHighLow.series[1].setData(data[1])

  setChartWeatherData()
  setChartHighLowData()
