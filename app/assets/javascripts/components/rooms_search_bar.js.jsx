/* globals React */
'use strict';

var RoomsSearchBar = React.createClass({
  render: function() {
    return (
      <div class='row pull-right margin-top well margin-right'>
        <form onSubmit={ this.submitted.bind(this) }>
          <input id='search' type='text' name='search'
                 placeholder="Room name, location, or amenity" size="30"/>
          <span> </span>
          <input id='room_number' type='text' name='search'
                 placeholder="#" size="3"/>
          <span> </span>
          <input id='max_occupancy' type='text' name='search'
                 placeholder="occ" size="3"/>
          <span> </span>
          <input type='submit' value='Search' className='btn btn-primary' />
        </form>
      </div>
    );
  },
  submitted: function (e) {
    e.preventDefault();
    var search = $('#search').val();
    var room_number = $('#room_number').val();
    var max_occupancy = $('#max_occupancy').val();
    var rooms_table = this.props.parent;
    var url = '/search/rooms'
    $.getJSON(url,
      {
        search: search,
        room_number: room_number,
        max_occupancy: max_occupancy
      },
      function (new_rooms_array) {
        rooms_table.setState({
          rooms_array: new_rooms_array,
          search: search,
          page: 1
        });
      }
    );
  }
});
