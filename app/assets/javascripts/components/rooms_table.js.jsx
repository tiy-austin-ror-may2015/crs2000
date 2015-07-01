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
              <TableHead parent={ this } />
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
              <TableHead parent={ this } />
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
              <TableHead parent={ this } />
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
              <TableHead parent={ this } />
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

var TableHead = React.createClass({
  render: function () {
    return(
      <thead>
        <tr>
          <SortButton name='Name' grandparent={ this.props.parent } />
          <SortButton name='Room Number' grandparent={ this.props.parent } />
          <SortButton name='Location' grandparent={ this.props.parent } />
          <SortButton name='Amenities' grandparent={ this.props.parent } />
          <SortButton name='Max Occupancy' grandparent={ this.props.parent } />
          <SortButton name='Time Until Next Meeting' grandparent={ this.props.parent } />
          <SortButton name='Available' grandparent={ this.props.parent } />
        </tr>
      </thead>
    );
  }
});

var SortButton = React.createClass({
  componentWillMount: function () {
    this.setState({
      sort_dir: null
    });
  },
  render: function () {
    return (
      <th onClick={ this.clicked } >{ this.props.name }</th>
    );
  },
  clicked: function () {
    var grandparent = this.props.grandparent;
    var array = grandparent.state.rooms_array;

    array.sort(function (a, b) {
      var room_a = a[0];
      var room_b = b[0];

      if (room_a.name > room_b.name) {
        return 1;
      }
      if (room_a.name < room_b.name) {
        return -1;
      }
      return 0;
    });
    grandparent.setState({ rooms_array: array, page: 1 })
  }
});

var DataRow = React.createClass({
  render: function () {
    var room = this.props.elem[0];
    var amenities = this.props.elem[1];
    var meetings = this.props.elem[2];
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
          time = next_start_time.toString();
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
        <td>{ room.max_occupancy }</td>
        <td className='well countDown' data-id={ time }></td>
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
    window.location.href = this.props.url;
  }
});
