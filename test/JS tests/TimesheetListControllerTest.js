/**
 * Created by arthur on 10/30/15.
 */

var mockBody;

function createTimesheetList(){
    var parentList = document.createElement('UL')
    var activityList = document.createElement('LI');
    activityList.setAttribute('class', 'activity-list')
    parentList.appendChild(activityList);
    return activityList;
}

function createListHeader(){
    var headerDiv = document.createElement('DIV');
    headerDiv.setAttribute('class', 'day-header');
    return headerDiv;
}

function createActivityList(){
    var list = document.createElement('UL');
    list.setAttribute('class', 'invisible');
    return list;
}

describe('Timesheet List Controller initialize', function(){

    beforeEach(function(){
        mockBody = document.createElement('DIV');
        document.body.appendChild(mockBody);
    });

    afterEach(function(){
       document.body.removeChild(mockBody);
    });

    it('should select the last list of activities on initialize', function(){
        var timesheetList1 = createTimesheetList();
        var dayHeader1 = createListHeader();
        var activityList1 = createActivityList();
        timesheetList1.appendChild(dayHeader1);
        timesheetList1.appendChild(activityList1);

        var timesheetList2 = createTimesheetList();
        var dayHeader2 = createListHeader();
        var activityList2 = createActivityList();
        timesheetList2.appendChild(dayHeader2);
        timesheetList2.appendChild(activityList2);

        var parentList = document.createElement('UL');
        parentList.appendChild(timesheetList1);
        parentList.appendChild(timesheetList2);

        mockBody.appendChild(parentList);

        TimesheetListController.initialize();

        expect(activityList1.getAttribute('class')).toBe('invisible');
        expect(activityList2.getAttribute('class')).toBe('visible');
    });


    it('works when multiple day lists are added to the page', function(){
        var timesheetList1 = createTimesheetList();
        var dayHeader1 = createListHeader();
        dayHeader1.id = '1';
        var activityList1 = createActivityList();
        activityList1.id = '1';
        timesheetList1.appendChild(dayHeader1);
        timesheetList1.appendChild(activityList1);

        var timesheetList2 = createTimesheetList();
        var dayHeader2 = createListHeader();
        dayHeader2.id = '2';
        var activityList2 = createActivityList();
        activityList2.id = '2';
        timesheetList2.appendChild(dayHeader2);
        timesheetList2.appendChild(activityList2);

        var timesheetList3 = createTimesheetList();
        var dayHeader3 = createListHeader();
        dayHeader3.id = '3';
        var activityList3 = createActivityList();
        activityList3.id = '3';
        timesheetList3.appendChild(dayHeader3);
        timesheetList3.appendChild(activityList3);

        var parentList = document.createElement('UL');
        parentList.appendChild(timesheetList1);
        parentList.appendChild(timesheetList2);
        parentList.appendChild(timesheetList3);

        mockBody.appendChild(parentList);

        TimesheetListController.initialize();

        expect(activityList1.getAttribute('class')).toBe('invisible');
        expect(activityList2.getAttribute('class')).toBe('invisible');
        expect(activityList3.getAttribute('class')).toBe('visible');

        dayHeader1.onclick();

        expect(activityList3.getAttribute('class')).toBe('invisible');
        expect(activityList2.getAttribute('class')).toBe('invisible');
        expect(activityList1.getAttribute('class')).toBe('visible');

        dayHeader2.onclick();

        expect(activityList1.getAttribute('class')).toBe('invisible');
        expect(activityList2.getAttribute('class')).toBe('visible');
        expect(activityList3.getAttribute('class')).toBe('invisible');

        dayHeader3.onclick();

        expect(activityList1.getAttribute('class')).toBe('invisible');
        expect(activityList2.getAttribute('class')).toBe('invisible');
        expect(activityList3.getAttribute('class')).toBe('visible');
    });
});
