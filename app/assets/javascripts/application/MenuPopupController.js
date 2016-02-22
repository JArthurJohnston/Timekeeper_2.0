/**
 * Created by arthur on 10/15/15.
 */

var MenuPopupcontroller = (function(){

    var menuPopupController = function(buttonSelector, menuSelector){
        this.isMenuVisible = false;
        this.menuItems = document.querySelector(menuSelector);
        this.menuButton = document.querySelector(buttonSelector);
    };

    function showMenu(context){
        context.menuItems.setAttribute('class', 'visible');
        context.isMenuVisible = true;
    };

    function hideMenu(context){
        context.menuItems.setAttribute('class', 'invisible');
        context.isMenuVisible = false;
    };

    function toggleMenu(context){
        if(context.isMenuVisible){
            hideMenu();
        } else {
            showMenu();
        }
    };

    return menuPopupController;

}());