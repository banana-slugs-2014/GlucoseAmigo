var Ajax = (function(){
  var _request = function(data,reaction){
    $.ajax(data)
    .done(function(response) {
      reaction(response);
    });

  }


  return {
    testGet: function(response){
      var data = {
        url: '/test',
      }
      _request(data,response);
    },
    get: function(url, response){
      _request({ url: url }, response)
    }
  }
}());
