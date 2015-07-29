google.load('visualization', '1', { packages: ['corechart', 'line'] });

function drawBasic(ticks) {
  var data = new google.visualization.DataTable();
  data.addColumn('number', 'X');
  data.addColumn('number', 'Value');
  data.addRows(ticks);

  var options = {
    hAxis: { title: 'Date and Time' },
    vAxis: { title: 'Value of Bitcoin' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('chart'));
  chart.draw(data, options);
}

function convertJSONtoArray(data) {
  var result = [], tick = [];

  for (var i=0; i < 50; i++) {
    tick = [i, data[i].last_price];
    result.push(tick);
  }

  return result;
}

$(document).on('ready page:load', function() {
  $.ajax({
    url: 'http://localhost:3000/ticks?count=75',
    method: 'get',
    dataType: 'json'
  }).done(function(ticksJSON) {
    var ticksArr = convertJSONtoArray(ticksJSON);
    google.setOnLoadCallback(drawBasic(ticksArr));
  });
});