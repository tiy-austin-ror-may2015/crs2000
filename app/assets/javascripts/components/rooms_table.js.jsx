/* globals React */
'use strict';

var RoomsTable = React.createClass({
  getInitialState: function () {
    return {
      rooms_array: this.props.rooms_array,
      page: 1,
      search: this.props.search,
      limit: parseInt(this.props.limit)
    };
  },
  render: function () {
    var rows = [];
    var i_0 = (this.state.page - 1) * this.state.limit;
    var i_f = 0;

    if (this.state.rooms_array.length < (this.state.page * this.state.limit)) {
      i_f = this.state.rooms_array.length;
    } else {
      i_f = i_0 + this.state.limit;
    }

    for (var i = i_0; i < i_f; i++) {
      rows.push(<DataRow elem={ this.state.rooms_array[i] } current_employee={ this.props.current_employee } />);
    }

    if (this.state.search === '') {
      var search_results = 'Search Results';
    } else {
      var search_results = 'Search Results for ';
    };

    return(
      <div>
        <h1 class="col-md-6">
          { search_results }<i class="results">{ this.state.search }</i>
        </h1>
        <div className='row'>
          <section className='col-md-3 panel panel-default limit'>
            <span>show </span>
            <input id='limit' type='text' size= '3' onKeyUp={ this.changed.bind(this) } />
            <span> rooms per page</span>
          </section>
          <div className='pull-right'>
            <RoomsSearchBar parent={ this } />
          </div>
        </div>
        <section className='panel panel-default'>
          <table className='table'>
            <TableHead parent={ this } />
            <tbody>
              {rows}
            </tbody>
          </table>
        </section>
        <Paginate parent={ this } />
      </div>
    );
  },
  changed: function (key) {
    if (key.keyCode === 13) {
      var new_limit = parseInt(key.target.value.trim());
      if (new_limit > 0) {
        this.setState({ limit: new_limit });
      }
    }
  }
});

var Paginate = React.createClass({
  render: function () {
    var rooms_table = this.props.parent;
    var limit = rooms_table.state.limit;
    var current_page = rooms_table.state.page;
    var data = rooms_table.state.rooms_array;
    var data_length = data.length;
    var last_page = Math.ceil((data_length || 1) / limit);
    var pages = [];

    for (var i = 1; i <= last_page; i++) {
      pages.push(<PageButton grandparent={ rooms_table } page={ i } />);
    };

    if (current_page === 1 && current_page === last_page) {
      return(<div></div>);
    } else if (current_page === 1 && current_page !== last_page) {
      return(
        <div className='row'>
          <div className='col-sm-2 next-prev'></div>
          <div onClick={ this.clicked.bind(this, 1)  } className='col-sm-2 btn btn-default next-prev'>Next</div>
          <div className='col-sm-7'>{ pages }</div>
        </div>
      );
    } else if (current_page === last_page) {
      return(
        <div className='row'>
          <div onClick={ this.clicked.bind(this, -1)  } className='col-sm-2 btn btn-default next-prev'>Prev</div>
          <div className='col-sm-2 next-prev'></div>
          <div className='col-sm-7'>{ pages }</div>
        </div>
      );
    } else {
      return(
        <div className='row'>
          <div onClick={ this.clicked.bind(this, -1)  } className='col-sm-2 btn btn-default next-prev'>Prev</div>
          <div onClick={ this.clicked.bind(this, 1)  } className='col-sm-2 btn btn-default next-prev'>Next</div>
          <div className='col-sm-7'>{ pages }</div>
        </div>
      );
    };
  },
  clicked: function (val) {
    var rooms_table = this.props.parent;
    rooms_table.setState({ page: rooms_table.state.page + val });
  }
});

var PageButton = React.createClass({
  render: function () {
    return(<a className='btn btn-default next-prev' onClick={ this.clicked } >{ this.props.page }</a>);
  },
  clicked: function () {
    this.props.grandparent.setState({ page: this.props.page });
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
            a = a[2].start_time;
            b = b[2].start_time;
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
            a = a[2].available;
            b = b[2].available;
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
    var current_employee = this.props.current_employee;
    var room_array = this.props.elem;
    var room = room_array[0];
    var amenity_names = room_array[1];
    var next_meeting_details = room_array[2];
    var start_time = next_meeting_details.start_time;
    var available = next_meeting_details.available;
    var next_meeting = next_meeting_details.next_meeting;
    var room_url = '/rooms/' + room.id;
    var meeting_url = '/meetings/';

    if ((next_meeting === null) || (current_employee.admin !== true && next_meeting.private === true)) {
      meeting_url = '';
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

var NavLink = React.createClass({
  render: function () {
    if (this.props.url !== ''){
      return (<a className={ this.props.className } data-id={ this.props.dataID } onClick={ this.clicked } >{ this.props.name }</a>);
    } else {
      return (<a className={ this.props.className } data-id={ this.props.dataID } >{ this.props.name }</a>);
    };
  },
  clicked: function () {
    window.location.href = this.props.url;
  }
});
