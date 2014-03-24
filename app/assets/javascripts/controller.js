var Controller = function(view){
  this.view = view
}

Controller.prototype = {
  nextPageEvent: function(response){
    this.view.reloadPage(response);
  },
  addAlert: function(alert){
    this.view.addAlert(alert);
  }
}
