var Ajax = (function(){
  var _request = function(data,reaction){
    $.ajax(data)
    .done(function(response) {
      console.log(response);
      reaction(response);
      console.log("success");
    });

  }


  return {
    testGet: function(response){
      var data = {
        url: '/test',
      }
      _request(data,response);
    }
  }
}());
