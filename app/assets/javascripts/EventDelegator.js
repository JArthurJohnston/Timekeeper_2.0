/**
 * Created by Arthur on 10/16/2015.
 */

var EventDelegator = (function(){

    var eventDelegator = function(elementSelector){
        this.commands = {};
        this.element = document.querySelector(elementSelector);
        this.element.onclick = processEventOnDelegator(this);
    };

    eventDelegator.prototype.processEvent = function(event){
        var actionToPerform = event.target.getAttribute('event-action');
        if(!actionToPerform == null){
            //console.log("Action: " + actionToPerform + "\n");
            this.commands[actionToPerform]();
        }
    };

    function processEventOnDelegator(context){
        return context.processEvent;
    };

    eventDelegator.prototype.handleCommand = function(eventType, command){
        this.commands[eventType] = command;
    };

    return eventDelegator;
}());