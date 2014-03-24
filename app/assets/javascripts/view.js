var View = function(){
  this.selectors = {
    navbarSelector: '#navbar',
    titleSelector: 'h1#title',
    contentSelector: '#content'
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
  },
  changeContent: function(html){
    $(this.selectors.contentSelector).html(html);
  },
  newPage: function(html){
    $('body').html(html);
  },
  reloadPage: function(html){
    this.changeContent(html);
    this.addNavBar(leftButton, rightButton);
    this.changeTitle(title);
  },
  addAlert: function(alert){
    console.log(alert);
  }
}
