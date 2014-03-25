var Controller = function(data) {
    this.view = data.view;
    this.user = data.user;
}

Controller.prototype = {
    nextPageEvent: function(response) {
        this.view.reloadPage(response);
    },
    addAlert: function(alert) {
        this.view.addAlert(alert);
    },
    logout: function() {
        Ajax.logout(this.user.uId, this.loadNextPage.bind(this));
    },
    addGraph: function(data) {
        Ajax.get(data.url, graph)
    },
    loadNextPage: function(response) {
        Ajax.get(response.target, this.view.newPage.bind(this.view));
    },
    loadNextPageFromData: function(data) {
        Ajax.get(data.url, this.nextPageEvent.bind(this));
    },
    loadSignUp: function(event) {
        Ajax.get(event.target.href, this.nextPageEvent.bind(this));
    },
    goBack: function(event) {
        Ajax.get(event.target.baseURI, this.view.newPage.bind(this.view))
    },
    getSubmenu: function(element) {
        Ajax.getSubmenu(element, this.view.addSubmenu.bind(this.view))
    },

}