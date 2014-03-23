var View = function(){
  this.selectors = {
    navbarSelector: '#navbar'
  };
  this.templates = HandlebarsTemplates;
}

View.prototype = {
  clearNavBar: function(){
    $(this.selectors.navbarSelector).empty();
  },
  addNavBar: function(left,right){
    this.clearNavBar();
    var template = this.templates.navbar;
    var context = {
                    'left-button': left,
                    'right-button': right
                  }
    $(this.selectors.navbarSelector).append(template(context));
  }

}
