google.load('visualization', '1', { packages: ['corechart', 'line'] });

function drawGraph(ticks, indicators) {
  var data = new google.visualization.DataTable();
  data.addColumn('datetime', 'Timestamp');
  data.addColumn('number', 'Value');
  data.addColumn({ type: 'string', role: 'annotation'});
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

function convertJSONtoArray(data) {
  var result = [], tick = [];
  var timestamp, price;
  var last = null;

  for (var i=data.length-1; i > 0; i--) {
    var time = new Date(data[i].datetime),
        price = data[i].last_price,
        tick = undefined,
        buy = data[i].good_buy,
        sell = data[i].good_sell;

    if (buy && last != "buy") {
      tick = [time, price, "buy:start"];
      last = "buy";
    } else if (sell && last != "sell") {
      tick = [time, price, "sell:start"];
      last = "sell";
    } else {
      // if (last == "buy") {
      //   tick = [time, price, "Stop Buying"];
      //   last = null;
      // } else if (last == "sell") {
      //   tick = [time, price, "Stop Selling"];
      //   last = null;
      // }
      tick = [time, price, null];
    }

    result.push(tick);
  }

  return result;
}

function createSeries(ticks) {
  var arr = {};
  // for (var i = 0; i < 5; i++) {
  for (var i = 0; i < ticks.length; i++) {
    if (ticks[i].good_buy == false && ticks[i].good_sell == false) {
      console.log("double false: " + i);
    } else {
      // console.log("Buy: " + ticks[i].good_buy);
      // console.log("Sell: " + ticks[i].good_sell);
    }
  //   if (ticks[i].good_buy) {
  //     arr[i] = {
  //       'point': {
  //         'shape-type': 'star',
  //         'shape-sides': 5,
  //         'shape-dent': 0.7,
  //         'fill-color': 'green'
  //       }
  //     };
  //   } else if (ticks[i].good_sell) {
  //     arr[i] = {
  //       'point': {
  //         'shape-type': 'star',
  //         'shape-sides': 5,
  //         'shape-dent': 0.7,
  //         'fill-color': 'red'
  //       }
  //     };
  //   } else {
  //     console.log("null: " + i);
  //     arr[i] = null;
  //   }
  }
  return arr;
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
      var ticksArr = convertJSONtoArray( ticksJSON ),
          series = createSeries( ticksJSON );

      google.setOnLoadCallback( drawGraph(ticksArr, series) );
    });
  };

  getChart();
});