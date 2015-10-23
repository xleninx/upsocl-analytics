function totalize(arr, key){
  return _.reduce(arr, function(memo, num){ return memo + num[key]; }, 0);
}

function toPercent(total, value){
  return (value * 100) / total
}

function progress_percent(arr, label, typeData){
  var today = arr[arr.length - 1][label];
  var last_day = arr[arr.length -2][label];
  var html_class;
  var progress_class;

  if (today < last_day){
    html_class = 'text-danger fa fa-level-down';
    progress_class = 'progress-bar progress-bar-danger';
    if (today <= 0) { today = 1; }
    if (typeData == 'time'){
      var percent = ((today - last_day) * 60) * 100;
    }else {
      var percent = (today - last_day) * 100;
    }
  }else{
    html_class = 'text-navy fa fa-level-up';
    progress_class = 'progress-bar';
    if (typeData == 'time'){
      var percent = ((today - last_day) * 60) * 100;
    }else {
      var percent = (today - last_day) * 100;
    }
  }

  return {percent: Math.abs(percent.toFixed()), html_class: html_class, progress_class: progress_class}
}

String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}
