/* globals React */
'use strict';

var DataRow = React.createClass({
  render: function () {
    var current_employee = this.props.current_employee;
    var room_array = this.props.elem;
    var room = room_array[0];
    var amenity_names = room_array[1];
    var next_meeting_details = room_array[2];
    var start_time = next_meeting_details.start_time;
    var available = next_meeting_details.available;
    var next_meeting = next_meeting_details.next_meeting;
    var inv_emp_ids = next_meeting_details.inv_emp_ids;
    var room_url = '/rooms/' + room.id;
    var meeting_url = getMeetingUrl(next_meeting, current_employee, inv_emp_ids);

    function getMeetingUrl(next_meeting, current_employee, inv_emp_ids) {
      if (next_meeting === null) {

        return '';

      } else if (isAdmin(current_employee)) {

        return '/meetings/' + next_meeting.id;

      } else if (isInvited(current_employee, inv_emp_ids)) {

        return '/meetings/' + next_meeting.id;

      } else if (!(next_meeting.private)) {

        return '/meetings/' + next_meeting.id;

      } else {

        return '';

      }
      function isAdmin(current_employee) {
        return (current_employee.admin ? true : false);
      }
      function isInvited(current_employee, inv_emp_ids) {
        return (inv_emp_ids.indexOf(current_employee.id) > -1 ? true : false);
      }
    }

    return (
      <tr>
        <td>
          <NavLink className='' dataID='' name={ room.name } url={ room_url } parent={ this } />
        </td>
        <td className='well'>{ room.room_number }</td>
        <td>{ room.location }</td>
        <td className='well'>{ amenity_names }</td>
        <td>{ room.max_occupancy }</td>
        <td className='well' >
          <NavLink className='countDown' dataID={ start_time } name='' url={ meeting_url }  />
        </td>
        <td>{ available }</td>
      </tr>
    );
  }
});
