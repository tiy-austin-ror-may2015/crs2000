/* globals $, moment */
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require dataTables/jquery.dataTables
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require moment
//= require datetimepicker
//= require_tree .

var ready = function() {
  $('.datetimepicker').datetimepicker();

  var times = $('.timeDisplay');
  times.each(function () {
    var time_text = $(this).html().format('MMMM/DD/YYYY hh:mm a');
    var formatted_time = moment(time_text);
    $(this).html(formatted_time);
  });
  var setTime = function () {
    var times = $('.countDown');
    times.each(function () {
      var time_text = $(this).attr("data-id");
      var formatted_time = moment(time_text).fromNow();
      $(this).html(formatted_time);
    });
      $("#search").on("keyup paste change", function(){
          var re = new RegExp(this.value,"i");
          $("#invitees tr").each(function(index){
              var invitee_name = $("#invitee_name", this).html();
              this.hidden = ! re.test(invitee_name);
          });
      });
  };
  setInterval(setTime, 5000);
  setTimeout(setTime, 0);
};

$(document).ready(ready);
$(document).on("page:load", ready);

// var = next_meet = $('.relTime');
// times.each(function() {
//   var time_text = $(this).html().format('hour');
//   var formatted_time = moment(time_text);
//   $(this).html(formatted_time);
// });
// moment().startOf('hour').fromNow();

