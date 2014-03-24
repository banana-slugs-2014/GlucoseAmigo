GlucoseAmigo = {}
$(document).ready(function(){
  GlucoseAmigo.user = new User();
  GlucoseAmigo.user.listenForLogin();
  GlucoseAmigo.view = new View();
  GlucoseAmigo.controller = new Controller({
    view: GlucoseAmigo.view,
    user: GlucoseAmigo.user
  })
  GlucoseAmigo.view.reloadPage();
  Binder.bind(GlucoseAmigo.controller);

});
