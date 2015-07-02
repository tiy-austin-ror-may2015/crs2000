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
      rows.push(<DataRow elem={ this.state.rooms_array[i] } current_employee={ this.props.current_employee } />);
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
  // getInitialState: function () {
  //   return {
  //     className: ''
  //   };
  // },
  componentWillMount: function () {
    this.setState({sort_dir: 'asc'});
  },
  render: function () {
    return (
      <th className={ this.state.className } onClick={ this.clicked } >{ this.props.name }</th>
    );
  },
  clicked: function () {
    var all_buttons = $('th');
      all_buttons.each(function () {
      $(this).removeClass('asc desc');
    });

    var grandparent = this.props.grandparent;
    var array = grandparent.state.rooms_array;

    var new_rooms_array = array.sort(
      function (a, b) {
        switch (this.props.name) {
          case 'Name':
            a = a[0].name.replace(/^(the )/i,'');
            b = b[0].name.replace(/^(the )/i,'');
            break;
          case 'Room Number':
            a = a[0].room_number;
            b = b[0].room_number;
            break;
          case 'Location':
            a = a[0].location;
            b = b[0].location;
            break;
          case 'Amenities':
            a = a[1]
            b = b[1]
            break;
          case 'Max Occupancy':
            a = a[0].max_occupancy;
            b = b[0].max_occupancy;
            break;
          case 'Time Until Next Meeting':
            a = a[2][0];
            b = b[2][0];
            if (a === 'N/A') {
              a = new Date(2038);;
            };
            if (b === 'N/A') {
              b = new Date(2038);;
            };
            a = new Date(a);
            b = new Date(b);
            break;
          case 'Available':
            a = a[2][1];
            b = b[2][1];
        }

        if (this.state.sort_dir === 'asc') {
          this.setState({
            sort_dir: 'desc',
            className: 'desc'
          });
          if (a > b) {
            return 1;
          }
          if (a < b) {
            return -1;
          }
          return 0;
        } else {
          this.setState({
            sort_dir: 'asc',
            className: 'asc'
          });
          if (a < b) {
            return 1;
          }
          if (a > b) {
            return -1;
          }
          return 0;
        }
      }.bind(this)
    );
    grandparent.setState({ rooms_array: new_rooms_array, page: 1 })
  }
});

var DataRow = React.createClass({
  render: function () {
    var room = this.props.elem[0];
    var amenity_names = this.props.elem[1];
    var time = this.props.elem[2][0];
    var available = this.props.elem[2][1];
    var next_meeting = this.props.elem[2][2];
    var current_employee = this.props.current_employee;
    var room_url = '/rooms/' + room.id;
    if (next_meeting === null) {
      var meeting_url = '';
    } else {
      if (next_meeting.private === true) {
        if (current_employee.admin === true) {
          var meeting_url = '/meetings/' + next_meeting.id;
        } else {
          var meeting_url = '';
        };
      } else {
        var meeting_url = '/meetings/' + next_meeting.id;
      };
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
          <NavLink className='countDown' dataID={ time } name='' url={ meeting_url }  />
        </td>
        <td>{ available }</td>
      </tr>
    );
  }
});

var NavLink = React.createClass({
  render: function () {
    return (<a className={ this.props.className } data-id={ this.props.dataID } onClick={ this.clicked } >{ this.props.name }</a>);
  },
  clicked: function () {
    window.location.href = this.props.url;
  }
});
