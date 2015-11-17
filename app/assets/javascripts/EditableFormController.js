/**
 * Created by arthur on 11/16/15.
 */

var EditableFormController = (function(){

    function initialize(){

    }

    function enableFields(){
        var changeForm = document.querySelector('#change-form');
        changeForm.setAttribute('class', 'change enabled-form');
        var inputs = changeForm.querySelectorAll('.change input');
        changeForm.querySelector('textArea').removeAttribute('disabled');
        changeForm.querySelector('select').removeAttribute('disabled');
        for(key in inputs){
            var eachInput = inputs[key];
            eachInput.originalValue = eachInput.innerHTML;
            eachInput.removeAttribute('disabled');
        }
    }

    function disableFields(){
        var changeForm = document.querySelector('#change-form');
        changeForm.setAttribute('class', 'change disabled-form');
        var inputs = changeForm.querySelectorAll('.change input');
        changeForm.querySelector('textArea').setAttribute('disabled', '');
        changeForm.querySelector('select').setAttribute('disabled', '');
        for(key in inputs){
            var eachInput = inputs[key];
            eachInput.innerHTML = eachInput.originalValue;
            eachInput.setAttribute('disabled', '');
        }
    }

    function wireEditButton(){
        var editButton = document.querySelector('#edit-discard-button');
        editButton.style.backgroundColor = '#00CC99';
        editButton.innerHTML = 'Edit';
        editButton.onclick = enableFields;
    }

    function wireDiscardButton(){
        var discardButton = document.querySelector('#edit-discard-button');
        discardButton.style.backgroundColor = '#ff9966';
        discardButton.innerHTML = 'Discard Changes';
        discardButton.onclick = disableFields;
    }



    return {
        initDisable: disableFields,
        initEnable: enableFields
    };

}());