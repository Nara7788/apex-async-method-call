/**
 * @description Platform event trigger. Creates an instance of the class by name and, since it implements the
 * Callable interface, executes the call method, where the payload is passed.
 */
trigger Method_Call_Event_Trigger on Method_Call__e (after insert) {
    for (Method_Call__e payload : Trigger.new) {
        Type classType = Type.forName(payload.Class__c);
        Callable instance = (Callable) classType.newInstance();
        instance.call(
                payload.Method__c,
                (Map<String, Object>) JSON.deserializeUntyped(payload.Arguments__c)
        );
    }
}