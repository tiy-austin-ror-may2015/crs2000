/* globals React */
'use strict';

var RoomsTable = React.createClass({
  getInitialState: function () {
    return {
      data: this.props.data,
      page: 1,
      limit: this.props.limit
    };
  },
  render: function () {
    var rows = [];
    var i_0 = (this.state.page - 1) * this.state.limit;
    var i_f = 0;

    if (this.state.data.length < (this.state.page * this.state.limit)) {
      i_f = this.state.data.length;
    } else {
      i_f = i_0 + parseInt(this.state.limit);
    }

    for (var i = i_0; i < i_f; i++) {
      rows.push(
        <div className='row'>
          <Row elem={ this.state.data[i] } />
        </div>
      );
    };

    if (this.state.page === 1 && i_f === this.state.data.length) {
      return (
        <div>
          <div className='row'>
            <div className='col-sm-3'>
              Search Results
            </div>
          </div>
          <div>{rows}</div>
        </div>
      );
    } else if (this.state.page === 1 && i_f < this.state.data.length) {
      return (
        <div>
          <div className='row'>
            <div className='col-sm-3'>
              Search Results
            </div>
          </div>
          <div>{rows}</div>
          <div className='row'>
            <div className='col-sm-2 next-prev'></div>
            <div onClick={ this.clicked.bind(this, 1)  } className='col-sm-2 btn btn-default next-prev'>Next</div>
          </div>
        </div>
      );
    } else if (i_f < this.state.data.length) {
      return (
        <div>
          <div className='row'>
            <div className='col-sm-3'>
              Search Results
            </div>
          </div>
          <div>{rows}</div>
          <div className='row'>
            <div onClick={ this.clicked.bind(this, -1)  } className='col-sm-2 btn btn-default next-prev'>Prev</div>
            <div onClick={ this.clicked.bind(this, 1)  } className='col-sm-2 btn btn-default next-prev'>Next</div>
          </div>
        </div>
      );
    } else {
      return (
        <div>
          <div className='row'>
            <div className='col-sm-3'>
              Search Results
            </div>
          </div>
          <div>{rows}</div>
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

var Row = React.createClass({
  getInitialState: function () {
    return {
      show: 'true'
    };
  },
  render: function () {
    if (this.state.show === 'true') {
      return (
        <div>
          <div className='col-sm-6'>
            <div className='row'>
              <div className='col-sm-12'>
                <ul className='details'>
                  <li>name: { this.props.elem.name }</li>
                  <li>room number: { this.props.elem.room_number }</li>
                  <li>location: { this.props.elem.location }</li>
                  <li>amenities: { this.props.elem.amenities[0].perk }</li>
                  <li>company: { this.props.elem.company.name }</li>
                  <li>max occupancy: { this.props.elem.max_occupancy }</li>
                  <li>hours until next meeting: { this.props.elem.hours_until_next_meeting }</li>
                  <li>available: { this.props.elem.available }</li>
                </ul>
                <div className='row'>
                  <NavLink name='Show' url={ '/rooms/' + this.props.elem.id } method='GET' parent={ this } />
                  <NavLink name='Edit' url={ '/rooms/' + this.props.elem.id + '/edit' } method='GET' parent={ this } />
                  <NavLink name='Destroy' url={ '/rooms/' + this.props.elem.id } method='DELETE' parent={ this } />
                </div>
              </div>
            </div>
          </div>
        </div>
      )
    } else {
      return (<div></div>)
    }
  }
});

var NavLink = React.createClass({
  getInitialState: function () {
    return {
      grandparent: this.props.grandparent
    };
  },
  render: function () {
    return (<a onClick={ this.clicked } className='btn btn-default'>{ this.props.name }</a>)
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
