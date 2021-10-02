# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
# alert $('#locations').data('url')

  $('ul#location-dropdown li').click ->
    event.preventDefault()
    $('button#location-selected').text($(this).text().trim())

  setInterval () ->
    console.log("run")
  , 60 * 1000

  # Load weather
  loc = { name: $('#location-selected').text() }
  Highcharts.getJSON 'https://demo-live-data.highcharts.com/aapl-c.json', (data) ->
    Highcharts.setOptions lang:
      rangeSelectorFrom: 'From'
      rangeSelectorTo: 'To'

    Highcharts.stockChart 'chart-weather',
      exporting: false
      legend:  enabled: true
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
            hover: {}
            select:
              fill: '#0D52FF'
              style: color: 'white'
              # disabled: { ... }

        inputBoxBorderColor: 'transparent',
        # inputBoxWidth: 120,
        # inputBoxHeight: 18,
        inputStyle:
          color: '#0D52FF'
          fontWeight: 'bold'
        labelStyle:
          color: 'gray'
          fontWeight: 'bold'
        selected: 1

      title:
        text: "Weather for <b>#{loc.name}</b>"

      series: [{
        name: 'AAPL'
        data: data
        type: 'spline'
        tooltip: {
          valueDecimals: 2
        }
      }]

      responsive: rules: [{
        condition:
          maxWidth: 500
        chartOptions:
          chart: height: 400
          subtitle: text: null
          navigator: enabled: false
      }]

  Highcharts.getJSON 'https://demo-live-data.highcharts.com/aapl-c.json', (data) ->
    Highcharts.setOptions lang:
      rangeSelectorFrom: 'From'
      rangeSelectorTo: 'To'

    Highcharts.stockChart 'chart-highlow',
      exporting: false
      legend:  enabled: true
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
            hover: {}
            select:
              fill: '#0D52FF'
              style: color: 'white'
          # disabled: { ... }

        # inputBoxBorderColor: 'transparent',
        # inputBoxWidth: 120,
        # inputBoxHeight: 18,
        inputStyle:
          color: '#0D52FF'
          fontWeight: 'bold'
        labelStyle:
          color: 'gray'
          fontWeight: 'bold'
        selected: 1

      title:
        text: "3-Hour Highs and Lows"

      series: [{
        name: 'AAPL'
        data: data
        type: 'spline'
        tooltip: {
          valueDecimals: 2
        }
      }]

      responsive: rules: [{
        condition:
          maxWidth: 500
        chartOptions:
          chart: height: 400
          subtitle: text: null
          navigator: enabled: false
      }]
