/* globals React */
'use strict';

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
