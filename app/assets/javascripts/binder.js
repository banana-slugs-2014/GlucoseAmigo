var Binder = (function(Ajax) {
        var _bindButtons = function(controller) {
            $('body')
                .off('click', 'button')
                .on('click', 'button', function(e) {
                    switch (_dataTypeOf(this)) {
                        case 'submit':
                            $('form').submit();
                            break;
                        case 'logout':
                            controller.logout();
                            break;
                        case 'cancel':
                            controller.goBack(e);
                            break;
                        case 'dashboard-button':
                            controller.loadNextPageFromData($(this).data());
                            break;
                        case 'add-record':
                            controller.loadAddRecord();
                            break;
                        case 'graph-button':
                            controller.addGraph($(this).data());
                            break;
                        case 'edit-diabetic-button':
                            controller.loadNextPageFromData($(this).data());
                            break;
                            w
                    }
                })
        }
        var _dataTypeOf = function(element) {
            return $(element).data('type')
        }

        var _bindLinks = function(controller) {
            $('body')
                .off('click', 'a')
                .on('click', 'a', function(e) {
                    if (_isSignUp(this)) {
                        controller.loadSignUp(e);
                    }
                })
        }


        var _bindDashboardMenu = function(controller) {
            $('body').on('change', '#menu_choice', function(event) {
                controller.getSubmenu($(this).find(':selected').val())
            });
        }

        var _isGetSubmenu = function(el) {
            return ($(el).data('type') === 'get-submenu')
        }

        var _isSignUp = function(el) {
            return ($(el).data('type') === 'signup')
        }


        var _bindAjaxForms = function(controller) {
            $('body')
                .off('ajax:success', 'form')
                .on('ajax:success', 'form', function(event, response) {
                    if (response.ok) {
                        Ajax.get(response.path, controller.nextPageEvent.bind(controller))
                    } else {
                        controller.addAlert(response.alert)
                    };
                })
        }

        return {
            bind: function(controller) {
                _bindButtons(controller);
                _bindAjaxForms(controller);
                _bindDashboardMenu(controller);

            }

        }(Ajax))