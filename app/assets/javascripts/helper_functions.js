function totalize(arr, key){
  return _.reduce(arr, function(memo, num){ return memo + num[key]; }, 0);
}

function toPercent(total, value){
  return (value * 100) / total
}

function size_legend(arr){
  var date_start = moment(_.first(arr)['date']);
  var date_end = moment(_.last(arr)['date']);
  var diff = date_end.diff(date_start, 'days');
  var limit = 1;

  if(diff > 70){
    limit = 15;
  }else if(diff > 30){
    limit = 5;
  }else if(diff > 20){
    limit = 2;
  }
  return limit;
}

function progress_percent(arr, label, typeData){
  var today = arr[arr.length - 1][label];
  var last_day = arr[arr.length -2][label];
  var html_class;
  var progress_class;

  if (today < last_day){
    html_class = 'text-danger fa fa-level-down';
    progress_class = 'progress-bar progress-bar-danger';
    if (last_day <= 0) { last_day = 1; }
    var percent = ((today - last_day) / last_day) * 100;
  }else{
    html_class = 'text-navy fa fa-level-up';
    progress_class = 'progress-bar';
    if (last_day <= 0) { last_day = 1; }
    var percent = ((today - last_day) / last_day) * 100;
  }

  return {percent: Math.abs(percent.toFixed()), html_class: html_class, progress_class: progress_class}
}

String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

function get_report(){
  var pdf = new jsPDF('p', 'in', [17,36]);
   var options = {
      pagesplit: false
  };
  $(".wrapper-content").css('background', '#f3f3f4')
  pdf.addHTML($('.wrapper-content'), 0, 0, options, function(){
      pdf.save("Upsocl Analitycs Report.pdf");
  });
}
