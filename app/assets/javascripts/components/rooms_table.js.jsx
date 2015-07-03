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
