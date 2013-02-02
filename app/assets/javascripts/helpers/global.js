function transformDate(day) {
  var new_day = day - 1
  if(new_day == -1){
    new_day = 6
  }
  return new_day
};

function daysInMonth(year, month) {
  return new Date(year, month, 0).getDate();
}

function firstDayOfTheMonth(year, month) {
  return new Date(year, month).mGetDay();
}

function lastDayOfTheMonth(year, month) {
  if(month = 12){
    month = 0
    year = year + 1
  } else {
    month = month + 1
  }
  return new Date(year, month, 0).mGetDay();
}

Date.prototype.mGetDay = function() {
  return (this.getDay() + 6) % 7;
}
