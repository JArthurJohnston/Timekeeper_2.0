/**
 * Created by arthur on 10/15/15.
 */
var ButtonBarController = (function(){
    var isMenuVisible, menuButton, buttonsBarPopup;

    function initialize() {
        isMenuVisible = false;
        menuButton = document.querySelector('#buttons-menu-icon');
        buttonsBarPopup = document.querySelector('#buttons-bar-popup');
        wireUpMenuButton();
    }

    function wireUpMenuButton(){
        menuButton.onclick = toggleMenu;
    }

    function showMenu(){
        buttonsBarPopup.setAttribute('class', 'visible');
        isMenuVisible = true;
    }

    function hideMenu(){
        buttonsBarPopup.setAttribute('class', 'invisible');
        isMenuVisible = false;
    }

    function toggleMenu(){
        if(isMenuVisible){
            hideMenu();
        } else {
            showMenu();
        }
    }

    return {
        initialize: initialize
    }
}());