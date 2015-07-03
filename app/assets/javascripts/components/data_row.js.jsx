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
    var room_url = '/rooms/' + room.id;

    if ((next_meeting === null) || (current_employee.admin !== true && next_meeting.private === true)) {
      var meeting_url = '';
    } else {
      var meeting_url = '/meetings/' + next_meeting.id;
    };

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
