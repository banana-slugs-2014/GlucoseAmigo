var Ajax = (function(){
  var _request = function(data,reaction){
    $.ajax(data)
    .done(function(response) {
      reaction(response);
    });
  }


  return {
    testGet: function(reaction){
      var data = {
        url: '/test', //don't commit test/debugging code to master
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
