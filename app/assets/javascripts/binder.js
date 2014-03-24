var Binder = (function(Ajax){
  var _bindButtons = function(controller){
    $('body')
    .off('click','button')
    .on('click', 'button', function(e){
      if (_isSubmit(this)) {
        $('form').submit();
      } else if (_isLogout(this)) {
        controller.logout();
      } else if (_isCancel(this)) {
        controller.goBack(e);
      }
    })
  }

  var _bindLinks = function(controller){
    $('body')
    .off('click', 'a')
    .on('click', 'a', function(e){
      if(_isSignUp(this)) {
        controller.loadSignUp(e);
      }
    })
  }

  var _isSubmit = function(el){
    return($(el).data('type') === 'submit')
  }
  var _isLogout = function(el){
    return($(el).data('type') === 'logout')
  }
  var _isCancel = function(el){
    return($(el).data('type') === 'cancel')
  }

  var _isSignUp = function(el){
    return($(el).data('type') === 'signup')
  }


  var _bindAjaxForms = function(controller){
    $('body')
    .off('ajax:success', 'form')
    .on('ajax:success', 'form', function(event, response){
      if(response.ok){
        console.log(response)
        Ajax.get(response.path, controller.nextPageEvent.bind(controller))
        console.log("worked?")
      } else {
        controller.addAlert(response.alert)
      };
    })
  }


  return {
    bind: function(controller){
      _bindButtons(controller);
      _bindAjaxForms(controller);
      _bindLinks(controller);
    }
  }

}(Ajax))
