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
        Ajax.logout(this.user.uId, this.redirectTo.bind(this));
    },
    redirectTo: function(data) {
        window.location.replace(data.path);
    },
    addGraph: function(data) {
        Ajax.get(data.url, this.graphAlert.bind(this))
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
        window.location.replace(event.target.baseURI);
    },
    getSubmenu: function(element) {
        Ajax.getSubmenu(element, this.view.addSubmenu.bind(this.view))
    },
    toggleRecordsPage: function() {
        this.view.toggleRecordsPage();
    },
    graphAlert: function(response) {
        if (response.check == "graph") {
            graph(response);
        } else {
            this.view.addAlert(response.alert);
        }

    }
}