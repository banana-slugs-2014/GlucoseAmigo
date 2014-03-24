var Binder = (function(Ajax){
  var _bindButtons = function(controller){
    $('body').on('click', 'button', function(e){
      if (_isSubmit(this)) {
        $('form').submit();
      } else if (_isLogout(this)) {
        controller.logout();
      }
    })
  }

  var _isSubmit = function(el){
    return($(el).data('type') === 'submit')
  }
  var _isLogout = function(el){
    return($(el).data('type') === 'logout')
  }


  var _ajaxFormBind = function(controller){
    $('body').on('ajax:success', 'form', function(event, response){
      if(response.ok){
        Ajax.get(response.target, controller.nextPageEvent.bind(controller))
      } else {
        controller.addAlert(response.alert)
      };
    })
  }

  var _logoutAjaxBind = function(controller){
    $('body').on('ajax:success', 'form', function(event, response){
      Ajax.get(response.target, controller.nextPageEvent.bind(controller))
    })
  }

  return {
    bind: function(controller){
      _bindButtons(controller);
      _ajaxFormBind(controller);
    }
  }

}(Ajax))
