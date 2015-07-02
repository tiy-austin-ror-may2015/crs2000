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

var formatTimes = function () {
  var times = $('.timeDisplay');
  times.each(function () {
    var time_text = $(this).html();
    var formatted_time = moment(time_text).format('MMMM/DD/YYYY hh:mm a');
    $(this).html(formatted_time);
  });
};

var formatCountdown = function () {
  var setTime = function () {
    var countdown_times = $('.countDown');
    countdown_times.each(function () {
      var time_text = $(this).attr("data-id");
      var formatted_time = moment(time_text).fromNow();
      $(this).html(formatted_time);
    });
  };
  setInterval(setTime, 5000);
  setTimeout(setTime, 0);
};

var inviteSearchFilter = function () {
  $("#search").on("keyup paste change", function(){
      var re = new RegExp(this.value, "i");
      $("#invitees tr").each(function(index){
          var invitee_name = $("#invitee_name", this).html();
          this.hidden = !re.test(invitee_name);
      });
  });
};

var ready = function() {
  $('.datetimepicker').datetimepicker();
  formatTimes();
  formatCountdown();
  inviteSearchFilter();
};

$(document).ready(ready);
$(document).on("page:load", ready);

