public with sharing class CastService {
    public static Object cast(Object o, Type t) {
        return JSON.deserialize(JSON.serialize(o), t);
    }

    public static Object castMultiTypeArguments(Object bulkArgValues, Map<String, String> typeNameByArgName) {
        Map<String, List<Object>> bulkValuesCastedByArgName = new Map<String, List<Object>>();
        Map<String, Object> bulkValuesByArgName = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(bulkArgValues));
        for (String argName : typeNameByArgName.keySet()) {
            Object bulkValues = bulkValuesByArgName.get(argName);
            Type bulkValuesType = Type.forName(typeNameByArgName.get(argName));
            List<Object> bulkValuesCasted = (List<Object>) cast(bulkValues, bulkValuesType);
            bulkValuesCastedByArgName.put(argName, bulkValuesCasted);
        }
        return bulkValuesCastedByArgName;
    }
}