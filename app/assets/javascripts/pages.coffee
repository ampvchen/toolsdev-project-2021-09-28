# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  setInterval () ->
    updateChartWeatherData()
  , ((60 * 1000) * 30)

  # Load weather
  loc = {
    id: $('#location-selected').attr('value')
    name: $('#location-selected').attr('name')
  }

  currentDay = () =>
    now = new Date()

    utc_start = Date.UTC(
      now.getUTCFullYear(),
      now.getUTCMonth(),
      now.getUTCDate(),
      0, 0, 0, 0)

    utc_stop = Date.UTC(
      now.getUTCFullYear(),
      now.getUTCMonth(),
      now.getUTCDate() ,
      now.getUTCHours(),
      now.getUTCMinutes(),
      now.getUTCSeconds(),
      now.getUTCMilliseconds())

    [utc_start, utc_stop]


  $('ul#location-dropdown li').click ->
    event.preventDefault()
    $('button#location-selected').text($(this).text().trim())
    loc.id = $(this).attr('value')
    loc.name = $(this).attr('name')
    updateChartWeatherData()

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
              cd= currentDay()
              chartWeather.xAxis[0].setExtremes(cd[0], cd[1], true)
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

      selected: 3

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

  chartDailyAverage = Highcharts.stockChart 'chart-daily-average',
    legend:  enabled: false
    title:
      text: "Daily Average"

    series: [{
      name: 'Average'
      type: 'spline'
      showInNavigator: true
      tooltip: {
        valueDecimals: 0
      }
    }]

  updateChartWeatherData = () ->
    setChartWeatherData()
    setChartHighLowData()
    setChartDailyAverage()

  setChartWeatherData = () ->
    $.get "/locations/#{loc.id}/temperatures", (data) ->
      chartWeather.series[0].setData(data[0])
      chartWeather.series[1].setData(data[1])
      chartWeather.setTitle({ text: "Weather for <b>#{loc.name}</b>" })

  setChartHighLowData = () ->
    $.get "/locations/#{loc.id}/temperatures/high_low", (data) ->
      chartHighLow.series[0].setData(data[0])
      chartHighLow.series[1].setData(data[1])

  setChartDailyAverage = () ->
    $.get "/locations/#{loc.id}/temperatures/daily_average", (data) ->
      chartDailyAverage.series[0].setData(data)

  updateChartWeatherData()
