/**
 * Created by arthur on 11/16/15.
 */

var EditableModelController = (function(){
    "use strict";

    var activityContentDiv,
        editActivityButton,
        editHTML,
        showHTML,
        isEditing;

    function initialize(editPage, showPage){
        activityContentDiv = document.getElementById('model-content');
        editActivityButton = document.getElementById('edit-model-button');
        editHTML = editPage;
        showHTML = showPage;
        isEditing = false;
        wireUpEditButton();
        renderDisplayDiv();
    }

    function wireUpEditButton(){
        editActivityButton.onclick = editButtonOnclick;
    }

    function renderEditForm(){
        activityContentDiv.innerHTML = editHTML;
    }

    function renderDisplayDiv(){
        activityContentDiv.innerHTML = showHTML;
    }

    function editButtonOnclick(){
        if(isEditing){
            renderDisplayDiv();
            isEditing = false;
            editActivityButton.innerHTML = 'Edit'
        }else{
            renderEditForm();
            isEditing = true;
            editActivityButton.innerHTML = 'Discard'
        }
    }

    return {
        initialize: initialize
    };

}());