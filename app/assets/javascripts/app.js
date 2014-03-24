GlucoseAmigo = {}
$(document).ready(function(){
  GlucoseAmigo.view = new View();
  GlucoseAmigo.controller = new Controller(GlucoseAmigo.view)
  GlucoseAmigo.view.reloadPage();
  Binder.bind(GlucoseAmigo.controller);
});
