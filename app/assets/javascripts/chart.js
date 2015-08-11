google.load('visualization', '1', { packages: ['corechart', 'line'] });

function drawGraph(ticks) {
  var data = new google.visualization.DataTable();
  data.addColumn('datetime', 'Timestamp');
  data.addColumn('number', 'Value');
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
        last = "buy";
        annotation = "buy"
      } else {
        annotation = null;
      }
    } else if (sell) {
      style = "stroke-color: red; fill-color: red";
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
  var values = {
    'buy_low' : $('#bl_range').text(),
    'buy_high' : $('#bh_range').text(),
    'sell_low' : $('#sl_range').text(),
    'sell_high' : $('#sh_range').text(),
  };

  function getChart() {
    $.ajax({
      url: 'http://localhost:3000/ticks',
      method: 'post',
      dataType: 'json',
      data: {
        'count': 100,
        'b1_calc': 'moving_avg',  'b1_range': values.buy_low,
        'b2_calc': 'moving_avg',  'b2_range': values.buy_high,
        's1_calc': 'moving_avg',  's1_range': values.sell_low,
        's2_calc': 'moving_avg',  's2_range': values.sell_high
      }
    }).done(function(ticksJSON) {
      var ticksArr = getTicksArray( ticksJSON );
      google.setOnLoadCallback( drawGraph(ticksArr) );
    });
  };

  getChart();
});