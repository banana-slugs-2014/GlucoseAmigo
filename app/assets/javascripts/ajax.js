var Ajax = (function(){
  var _request = function(data,reaction){
    $.ajax(data)
    .done(function(response) {
      reaction(response);
    });
  }


  return {
    getSubmenu: function(submenu, reaction){
      var data = {
        url: '/accounts/submenu',
        data: { 'menu_choice': submenu }
      }
      _request(data, reaction)
    },
    get: function(url, reaction){
      _request({ url: url }, reaction)
    },
    logout: function(userId, reaction){
      _request({
        type: 'DELETE',
        url: '/sessions/'+userId
      }, reaction)
    }
  }
}());
