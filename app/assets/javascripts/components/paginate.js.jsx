/* globals React */
'use strict';

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
