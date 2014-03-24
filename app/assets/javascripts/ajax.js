var Ajax = (function(){
  var _request = function(data,reaction){
    $.ajax(data)
    .done(function(response) {
      console.log(response)
      reaction(response);
    });
  }


  return {
    testGet: function(reaction){
      var data = {
        url: '/test',
      }
      _request(data,reaction);
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
