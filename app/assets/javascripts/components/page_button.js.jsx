/* globals React */
'use strict';

var PageButton = React.createClass({
  render: function () {
    var className = 'btn btn-default next-prev pageButton'
    if (this.props.grandparent.state.page === this.props.page) {
      className = 'btn btn-primary next-prev pageButton'
    };
    return(<a className={ className } onClick={ this.clicked } >{ this.props.page }</a>);
  },
  clicked: function () {
    this.props.grandparent.setState({ page: this.props.page });
  }
});
