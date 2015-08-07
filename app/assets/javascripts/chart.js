google.load('visualization', '1', { packages: ['corechart', 'line'] });

function drawGraph(ticks) {
  var data = new google.visualization.DataTable();
  data.addColumn('datetime', 'Timestamp');
  data.addColumn('number', 'Value');
  // data.addColumn({ type: 'string', role: 'annotation' });
  data.addColumn({ type: 'string', role: 'style' });
  data.addRows(ticks);

  var options = {
    crosshair: {
      trigger: 'focus',
      orientation: 'vertical',
    },
    vAxis: {
      viewWindowMode: 'explicit',
      format: 'currency',
    },
    backgroundColor: { fill: 'transparent' },
    legend: { position: 'none' },
  };

  var chart = new google.visualization.AreaChart( document.getElementById('chart') );
  chart.draw(data, options);
}

function getTicksArray(data) {
  var result = [], tick = [],
      timestamp, price,
      last = null,
      annotation = null
      style = null;

  for (var i=data.length-1; i > 0; i--) {
    var time = new Date(data[i].datetime),
        price = data[i].last_price,
        tick = undefined,
        buy = data[i].good_buy,
        sell = data[i].good_sell;

    if (buy) {
      style = "stroke-color: green; fill-color: green";
      if (last != "buy") {
        console.log(data[i]);
        last = "buy";
        annotation = "buy"
      } else {
        annotation = null;
      }
    } else if (sell) {
      style = "stroke-color: blue; fill-color: blue";
      if (last != "sell") {
        last = "sell";
        annotation = "sell"
      } else {
        annotation = null;
      }
    } else {
      style = "stroke-color: blue; fill-color: blue";
    }

    result.push( [time, price, style] );
  }

  return result;
}

$(document).on('ready page:load', function() {
  function getChart() {
    $.ajax({
      url: 'http://localhost:3000/ticks',
      method: 'post',
      dataType: 'json',
      data: {
        'count': 100,
        'b1_calc': 'moving_avg',  'b1_range': 7,
        'b2_calc': 'moving_avg',  'b2_range': 30,
        's1_calc': 'moving_avg',  's1_range': 30,
        's2_calc': 'moving_avg',  's2_range': 7,
      }
    }).done(function(ticksJSON) {
      var ticksArr = getTicksArray( ticksJSON );
      google.setOnLoadCallback( drawGraph(ticksArr) );
    });
  };

  getChart();
});