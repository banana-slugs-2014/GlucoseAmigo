GlucoseAmigo = {}
$(document).ready(function(){
  GlucoseAmigo.user = new User();
  GlucoseAmigo.user.listenForLogin();
  GlucoseAmigo.view = new View();
  GlucoseAmigo.controller = new Controller(GlucoseAmigo.view)
  GlucoseAmigo.view.reloadPage();
  Binder.bind(GlucoseAmigo.controller);

  
  $('body').trigger('login', userid)
});
