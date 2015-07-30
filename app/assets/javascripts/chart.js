google.load('visualization', '1', { packages: ['corechart', 'line'] });

function drawGraph(ticks) {
  var data = new google.visualization.DataTable();
  data.addColumn('datetime', 'Timestamp');
  data.addColumn('number', 'Value');
  data.addRows(ticks);

  var options = {
    hAxis: {
      // title: 'Timeline'
    },
    vAxis: {
      // title: 'Value of Bitcoin',
      viewWindowMode: 'explicit',
      // viewWindow: {
      //   min: 290,
      //   max: 285,
      // },
      format: 'currency',
    },
    // lineWidth: 3,
    backgroundColor: {
      fill: 'transparent'
    },
    legend: {
      position: 'none'
    }
  };

  var chart = new google.visualization.LineChart(document.getElementById('chart'));
  chart.draw(data, options);
}

function convertJSONtoArray(data) {
  var result = [], tick = [];
  var timestamp, price;

  for (var i=data.length-1; i > 0; i--) {
    time = new Date(data[i].datetime);
    price = data[i].last_price;
    tick = [time, price];
    result.push(tick);
  }

  return result;
}

$(document).on('ready page:load', function() {
  function getChart() {
    $.ajax({
      url: 'http://localhost:3000/ticks',
      method: 'get',
      dataType: 'json'
    }).done(function(ticksJSON) {
      var ticksArr = convertJSONtoArray(ticksJSON);
      google.setOnLoadCallback(drawGraph(ticksArr));
      setTimeout( getChart, 30000 );
    });
  };

  getChart();
});