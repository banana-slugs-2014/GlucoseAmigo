var Binder = (function(){
  var _bindSubmit = function(){
    $('body').on('click', 'button', function(){
      if($(this).data('type') == 'submit'){
        console.log('submit')
        $('form').submit();
      }
    })
  }

  return {
    bind: function(){
      _bindSubmit();
    }
  }

}())
