var View = function(){
  this.selectors = {
    navbarSelector: '#navbar',
    titleSelector: 'h1#title',
    contentSelector: '#content',
    submenuSelector: '#submenu',
    recordsSummarySelector: '#records-summary',
    recordsGraphSelector: '#records-graph',
    recordsToggleButtonSelector: '#records-toggle-button'
  };
  this.templates = HandlebarsTemplates;
  this.toggleButtonText = ['Graph','Records']
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
  },
  addSubmenu: function(menu){
    $(this.selectors.submenuSelector).html(menu);
  },
  toggleRecordsPage: function(){
    $(this.selectors.recordsSummarySelector).toggle();
    $(this.selectors.recordsGraphSelector).toggle();
    this.switchRecordsToggleButton();
  },
  switchRecordsToggleButton: function(){
    var button = this.selectors.recordsToggleButtonSelector
    if ($(button).text() === this.toggleButtonText[0]){
      $(button).text(this.toggleButtonText[1])
    }else{
      $(button).text(this.toggleButtonText[0])
    }
  }
}
