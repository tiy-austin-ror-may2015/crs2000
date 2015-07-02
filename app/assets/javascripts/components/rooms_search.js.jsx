/* globals React */
'use strict';

var RoomsSearch = React.createClass({
  render: function() {
    return (
      <div class="row">
        <div class="col-md-9"></div>
        <div class='col-md-3 well center room-search'>
          <form onSubmit={ this.submitted.bind(this) }>
            <div class='row'>
              <div class='col-md-4 align-right'>name</div>
              <div class='col-md-8 align-left'>
                <input id='name' type='text' size= '12' name='name'/>
              </div>
            </div>
            <div class='row'>
              <div class='col-md-4 align-right'>location</div>
              <div class='col-md-8 align-left'>
                <input id='location' type='text' size= '12' name='location'/>
              </div>
            </div>
            <div class='row'>
              <div class='col-md-4 align-right'>number</div>
              <div class='col-md-8 align-left'>
                <input id='room_number' type='text' size= '3' name='room_number'/>
              </div>
            </div>
            <div class='row'>
              <div class='col-md-4 align-right'>max occ</div>
              <div class='col-md-8 align-left'>
                <input id='max_occupancy' type='text' size= '3' name='max_occupancy'/>
              </div>
            </div>
            <div class='row'>
              <div class='col-md-4 align-right'>available?</div>
              <div class='col-md-8 align-left'>
                <input id='available' type='checkbox' checked = 'checked' name='available' value='true' />
              </div>
            </div>
            <div class='row'>
              <div class='col-md-4'></div>
              <div class='col-md-8 align-left'>
                <input type='submit' value='Search' class='btn btn-primary' />
              </div>
            </div>
          </form>
        </div>
      </div>
    );
  },
  submitted: function (e) {
    e.preventDefault();
    var name = $('#name').val();
    var location = $('#location').val();
    var room_number = $('#room_number').val();
    var max_occupancy = $('#max_occupancy').val();
    var available = $('#available').val();
    var rooms_table = this.props.parent;
    var url = '/search_advance/rooms'
    $.getJSON(url,
      {
        name: name,
        location: location,
        room_number: room_number,
        max_occupancy: max_occupancy,
        available: available
      },
      function (new_rooms_array) {
        rooms_table.setState({ rooms_array: new_rooms_array });
      }
    );
  }
});
