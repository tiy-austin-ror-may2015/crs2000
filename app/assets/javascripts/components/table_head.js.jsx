/* globals React */
'use strict';

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
