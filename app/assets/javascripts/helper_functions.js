function totalize(arr, key){
  return _.reduce(arr, function(memo, num){ return memo + num[key]; }, 0);
}
function toPercent(total, value){
    return (value * 100) / total
}
String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}
