/* globals React */
'use strict';

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
