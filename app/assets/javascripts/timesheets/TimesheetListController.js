/**
 * Created by arthur on 10/28/15.
 */
var TimesheetListController = (function(){

    function wireUpActivityList(){
        var timesheetDays = document.querySelectorAll('.activity-list');
        for(var i = 0; i < timesheetDays.length; i++){
            var eachDay = timesheetDays[i];
            var eachDayHeader =  eachDay.children[0];
            var activityList = eachDay.children[1];
            eachDayHeader.onclick = toggleActivityList(activityList);
        }
        toggleActivityList(timesheetDays[timesheetDays.length - 1].children[1])();
    };

    function toggleActivityList(listToToggle){
        return function(){
            hideAllLists();
            if(listToToggle.getAttribute('class') == 'invisible'){
                listToToggle.setAttribute('class', 'visible')
            } else {
                listToToggle.setAttribute('class', 'invisible');
            }
        };
    };

    function hideAllLists(){
        var activityLists = document.querySelectorAll('.activity-list ul');
        for(var i = 0; i < activityLists.length; i++){
            var eachList = activityLists[i];
            eachList.setAttribute('class', 'invisible');
        }
    };

    return {initialize: wireUpActivityList};
}());