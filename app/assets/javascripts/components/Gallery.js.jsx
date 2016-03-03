var Gallery = React.createClass({
  getInitialState: function(){
    return {data: [], authorized: false};
  },

  loadData: function() {
    $.ajax({
      url: '/api/photos.json',
      dataType: 'json',
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error('#GET Error', status, err.toString());
      }.bind(this)
    });
  },

  componentDidMount: function() {
    this.loadData();
  },

  componentWillUnmount: function() {
    this.serverRequest.abort();
  },

  render: function() {
    if (!this.state.data.photos) {
      return null;
    }
    console.log(this.state.data);
    var that = this;
    return (
      <div className="g">
        {

          this.state.data.photos.map(function(item) {
            return <GalleryItem key={item.id} data={item} authorized={that.state.authorized} />;
          })
        }
      </div>
    )
  }
});

// var GalleryList = React.createClass({
//   render: function() {
//     if (!this.props.data.photos) {
//       return null;
//     }
//     console.log(this.props.data);
//     return (
//       <div className="g">
//         {
//           this.props.data.photos.map(function(item) {
//             return <GalleryItem key={item.id} data={item} authorized={this.props.authorized} />;
//           })
//         }
//       </div>
//     )
//   }
// });

var GalleryItem = React.createClass({
  getInitialState: function() {
    return {liked: false};
  },
  handleClick: function(event) {
    this.setState({liked: !this.state.liked});
  },
  render: function() {
    // var liked_class = ;
    console.log('authorized', this.props.authorized)
    return <div className="g-item">
      <div className="g-item__top">
        
        <div className={'g-item__like ' + (this.state.liked ? 'g-item__like--liked' : '')} onClick={this.handleClick}></div>
        <div className="g-item__username">{this.props.data.username}</div>
      </div> 
      <div className="g-item__image">
        <img width="274" src={this.props.data.src} />
      </div>
      <div className="g-item__auth">
        <div className="g-item__auth-title">авторизируйся через соцсеть</div>
        <div className="g-item__auth-item g-item__auth-item--fb">fb</div>
        <div className="g-item__auth-item g-item__auth-item--in">in</div>
        <div className="g-item__auth-item g-item__auth-item--vk">vk</div>
      </div>
    </div>
  }
});
