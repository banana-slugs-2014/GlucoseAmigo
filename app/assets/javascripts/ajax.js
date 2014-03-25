var Ajax = (function(){
  var _request = function(data,reaction){
    $.ajax(data)
    .done(function(response) {
      reaction(response);
    });
  }


  return {
    get: function(url, reaction){
      _request({ url: url }, reaction)
    },
    getSubmenu: function(submenu, reaction){
      var data = {
        url: '/accounts/submenu',
        data: { 'menu_choice': submenu }
      }
      _request(data, reaction)
    },
    getEdit: function(type,id,reaction){
      var url = '/'+type+'/'+id+'/edit'
      this.get(url, reaction)
    },
    logout: function(userId, reaction){
      _request({
        type: 'DELETE',
        url: '/sessions/'+userId
      }, reaction)
    }
  }
}());
