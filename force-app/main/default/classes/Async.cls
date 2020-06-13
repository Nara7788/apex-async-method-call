/**
 * Created by Yevhen Kharchuk on 12-Jun-20.
 */

public with sharing class Async {
    public static void execute(Type classType, String methodName, Map<String, Object> args) {
        Database.SaveResult results = EventBus.publish(
                new Method_Call__e(
                        Class__c = classType.getName(),
                        Method__c = methodName,
                        Arguments__c = JSON.serialize(args)
                ));
    }

    public static void executeImmediate() {

    }

    public static Object cast(Object o, Type t){
        return JSON.deserialize(JSON.serialize(o), t);
    }
}