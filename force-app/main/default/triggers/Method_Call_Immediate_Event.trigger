/**
 * @description Platform event trigger. Creates an instance of the class by name and, since it implements the
 * Callable interface, executes the call method, where the payload is passed. Immediate means that event is fired
 * before transaction ends.
 */
trigger Method_Call_Immediate_Event on Method_Call_Immediate__e (after insert) {
    for (Method_Call_Immediate__e payload : Trigger.new) {
        Type classType = Type.forName(payload.Class__c);
        Callable instance = (Callable) classType.newInstance();
        instance.call(
                payload.Method__c,
                (Map<String, Object>) JSON.deserializeUntyped(payload.Arguments__c)
        );
    }
}