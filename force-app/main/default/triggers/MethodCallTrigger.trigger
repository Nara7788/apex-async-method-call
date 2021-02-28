/**
 * @description Platform event trigger. Creates an instance of the class by name and, since it implements the
 * Callable interface, executes the call method, where the payload is passed. Immediate means that event is fired
 * before transaction ends.
 */
trigger MethodCallTrigger on MethodCall__e (after insert) {
    for (MethodCall__e payload : Trigger.new) {
        Type classType = Type.forName(payload.Class__c);
        Callable instance = (Callable) classType.newInstance();
        instance.call(
                payload.Method__c,
                (Map<String, Object>) JSON.deserializeUntyped(payload.Arguments__c)
        );
    }
}