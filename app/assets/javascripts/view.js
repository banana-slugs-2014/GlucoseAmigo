var View = function(){
  this.selectors = {
    navbarSelector: '#navbar',
    titleSelector: 'h1#title'
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
  },
  changeTitle: function(title){
    $(this.selectors.titleSelector).text(title);
  }
}
