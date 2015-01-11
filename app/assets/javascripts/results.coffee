# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.ui.accordion').accordion()

  if $("#chart").length
    ctx = $("#chart").get(0).getContext("2d")
    labels = []
    data = []
    for item in window.calendar
      labels.push item[0]
      data.push item[1]

    chart_data = {
      labels: labels
      datasets: [
        {
          fillColor: fill_color
          data: data
        }
      ]
    }

    window.chart = new Chart(ctx).Bar(chart_data, {
      responsive: true
      barShowStroke : false
      barValueSpacing : 1
      barDatasetSpacing : 1
      legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].lineColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"
    })

    legend = chart.generateLegend();
    $('#chart').append(legend);

    $('canvas').on 'click', (evt) ->
      activeBars = chart.getBarsAtEvent(evt)
      console.log activeBars
