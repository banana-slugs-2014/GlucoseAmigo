var Binder = (function(Ajax){
  var _bindButtons = function(){
    $('body').on('click', 'button', function(){
      if(_isSubmit(this)){
        $('form').submit();
      }
    })
  }

  var _isSubmit = function(el){
    return($(el).data('type') == 'submit')
  }


  var _ajaxBind = function(controller){
    $('body').on('ajax:success', '#account-login', function(event, response){
      if(response.ok){
        Ajax.get(response.target, controller.nextPageEvent.bind(controller))
      } else {
        controller.addAlert(response.alert)
      };
    })
  }

  return {
    bind: function(controller){
      _bindButtons();
      _ajaxBind(controller);
    }
  }

}(Ajax))
