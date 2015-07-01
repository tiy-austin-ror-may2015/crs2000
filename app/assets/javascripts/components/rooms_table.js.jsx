/* globals React */
'use strict';

var RoomsTable = React.createClass({
  getInitialState: function () {
    return {
      rooms_array: this.props.rooms_array,
      page: 1,
      limit: this.props.limit
    };
  },
  render: function () {
    var rows = [];
    var i_0 = (this.state.page - 1) * this.state.limit;
    var i_f = 0;

    if (this.state.rooms_array.length < (this.state.page * this.state.limit)) {
      i_f = this.state.rooms_array.length;
    } else {
      i_f = i_0 + parseInt(this.state.limit);
    }

    for (var i = i_0; i < i_f; i++) {
      rows.push(<DataRow elem={ this.state.rooms_array[i] } />);
    }

    if (this.state.page === 1 && i_f === this.state.rooms_array.length) {
      return (
        <div>
          <section className='panel panel-default'>
            <table className='table'>
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Room Number</th>
                  <th>Location</th>
                  <th>Amenities</th>
                  <th>Company</th>
                  <th>Max Occupancy</th>
                  <th>Time Until Next Meeting</th>
                  <th>Available</th>
                </tr>
              </thead>
              <tbody>
                {rows}
              </tbody>
            </table>
          </section>
        </div>
      );
    } else if (this.state.page === 1 && i_f < this.state.rooms_array.length) {
      return (
        <div>
          <section className='panel panel-default'>
            <table className='table'>
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Room Number</th>
                  <th>Location</th>
                  <th>Amenities</th>
                  <th>Company</th>
                  <th>Max Occupancy</th>
                  <th>Time Until Next Meeting</th>
                  <th>Available</th>
                </tr>
              </thead>
              <tbody>
                {rows}
              </tbody>
            </table>
          </section>
          <div className='row'>
            <div className='col-sm-2 next-prev'></div>
            <div onClick={ this.clicked.bind(this, 1)  } className='col-sm-2 btn btn-default next-prev'>Next</div>
          </div>
        </div>
      );
    } else if (i_f < this.state.rooms_array.length) {
      return (
        <div>
          <section className='panel panel-default'>
            <table className='table'>
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Room Number</th>
                  <th>Location</th>
                  <th>Amenities</th>
                  <th>Company</th>
                  <th>Max Occupancy</th>
                  <th>Time Until Next Meeting</th>
                  <th>Available</th>
                </tr>
              </thead>
              <tbody>
                {rows}
              </tbody>
            </table>
          </section>
          <div className='row'>
            <div onClick={ this.clicked.bind(this, -1)  } className='col-sm-2 btn btn-default next-prev'>Prev</div>
            <div onClick={ this.clicked.bind(this, 1)  } className='col-sm-2 btn btn-default next-prev'>Next</div>
          </div>
        </div>
      );
    } else {
      return (
        <div>
          <section className='panel panel-default'>
            <table className='table'>
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Room Number</th>
                  <th>Location</th>
                  <th>Amenities</th>
                  <th>Company</th>
                  <th>Max Occupancy</th>
                  <th>Time Until Next Meeting</th>
                  <th>Available</th>
                </tr>
              </thead>
              <tbody>
                {rows}
              </tbody>
            </table>
          </section>
          <div className='row'>
            <div onClick={ this.clicked.bind(this, -1) } className='col-sm-2 btn btn-default next-prev'>Prev</div>
          </div>
        </div>
      );
    }
  },
  clicked: function (val) {
    this.setState({ page: this.state.page + val });
  }
});

var DataRow = React.createClass({
  render: function () {
    var room = this.props.elem[0];
    var company = this.props.elem[1];
    var amenities = this.props.elem[2];
    var meetings = this.props.elem[3];
    var amenity_names = [];
    var now = new Date();
    var time = 'N/A';
    var available = 'yes';

    amenities.forEach(function(amenity) {
      amenity_names.push(amenity.perk);
    });
    amenity_names.join(', ');

    if (meetings.length > 0) {
      var next_start_time = new Date(meetings[0].start_time);
      meetings.forEach(function(meeting, i) {
        var start_time = new Date(meeting.start_time);
        var end_time = new Date(meeting.end_time);
        if (start_time <= now && end_time >= now) {
          available = 'no';
        };
        if (start_time > now && start_time <= next_start_time) {
          next_start_time = start_time;
          time = moment(next_start_time);
        };
      });
    };

    return (
      <tr>
        <td>
          <NavLink name={ room.name } url={ '/rooms/' + room.id } method='GET' parent={ this } />
        </td>
        <td className='well'>{ room.room_number }</td>
        <td>{ room.location }</td>
        <td className='well'>{ amenity_names }</td>
        <td>{ company.name }</td>
        <td className='well'>{ room.max_occupancy }</td>
        <td id='countdown-holder'>{ time.format('MMMM/DD/YYYY hh:mm a') }</td>
        <td className='well'>{ available }</td>
      </tr>
    );
  }
});

var NavLink = React.createClass({
  getInitialState: function () {
    return {
      grandparent: this.props.grandparent
    };
  },
  render: function () {
    return (<a onClick={ this.clicked } >{ this.props.name }</a>);
  },
  clicked: function () {
    if (this.props.method === 'DELETE') {
      $.ajax({
        url: this.props.url,
        type: 'DELETE',
        error: function () {
          this.state.grandparent.setState({ show: 'false'});
        }.bind(this)
      });
    } else {
      window.location.href = this.props.url;
    }
  }
});
