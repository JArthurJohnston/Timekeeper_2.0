/**
 * Created by arthur on 10/15/15.
 */
var ButtonBarController = (function(){
    var isMenuVisible, buttonsBar, buttonsBarPopup;

    function initialize() {
        isMenuVisible = false;
        buttonsBar = document.querySelector('#buttons-bar');
        buttonsBarPopup = document.querySelector('#buttons-bar-popup');
        wireUpMenuButton();
    }

    function wireUpMenuButton(){
        buttonsBar.onclick = toggleMenu;
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