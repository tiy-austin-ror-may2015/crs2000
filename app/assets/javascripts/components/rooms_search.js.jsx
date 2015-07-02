/* globals React */
'use strict';

var RoomsSearch = React.createClass({
  render: function() {
    return (
      <div class="row">
        <form onSubmit={ this.submitted.bind(this) }>
          <span>name </span>
          <input id='name' type='text' size= '12' name='name'/>
          <span> location </span>
          <input id='location' type='text' size= '12' name='location'/>
          <span> number </span>
          <input id='room_number' type='text' size= '3' name='room_number'/>
          <span>{ ' max occ >= ' }</span>
          <input id='max_occupancy' type='text' size= '3' name='max_occupancy'/>
          <span> </span>
          <input type='submit' value='Search' className='btn btn-primary' />
        </form>
      </div>
    );
  },
  submitted: function (e) {
    e.preventDefault();
    var name = $('#name').val();
    var location = $('#location').val();
    var room_number = $('#room_number').val();
    var max_occupancy = $('#max_occupancy').val();
    var rooms_table = this.props.parent;
    var url = '/search_advance/rooms'
    $.getJSON(url,
      {
        name: name,
        location: location,
        room_number: room_number,
        max_occupancy: max_occupancy
      },
      function (new_rooms_array) {
        rooms_table.setState({
          rooms_array: new_rooms_array,
          page: 1
        });
      }
    );
  }
});
