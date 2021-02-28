public with sharing class Async {
    public static void execute(String className, String methodName, Map<String, Object> args) {
        EventBus.publish((SObject)
                new MethodCall__e(
                        Class__c = className,
                        Method__c = methodName,
                        Arguments__c = JSON.serialize(args)
                ));
    }
}