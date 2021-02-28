public with sharing class MethodAsyncBulkProcessor implements Callable {
    private Map<String, String> bulkArgTypeByArgName;
    public void execute(String className, String methodName, Map<String, List<Object>> bulkValuesByArgName, Map<String, String> bulkArgTypeByArgName) {
        runMethodAsyncUpTo149Times(className, methodName, bulkValuesByArgName, bulkArgTypeByArgName);
        if (hasMoreArgValues(bulkValuesByArgName)) {
            splitContextAndRepeat(className, methodName, bulkValuesByArgName);
        }
    }

    public Object call(String methodName, Map<String, Object> args) {
        switch on methodName {
            when 'execute' {
                Object firstArg = args.get('obj');
                Object secondArg = args.get('methodName');
                Object thirdArg = args.get('bulkValuesByArgName');
                Object fourthArg = args.get('bulkArgTypeByArgName');

                String firsArgCasted = (String) CastService.cast(firstArg, String.class);
                String secondArgCasted = (String) CastService.cast(secondArg, String.class);
                Map<String, String> fourthArgCasted = (Map<String, String>) CastService.cast(fourthArg, Map<String, String>.class);
                Map<String, List<Object>> thirdArgCasted = (Map<String, List<Object>>) CastService.castMultiTypeArguments(thirdArg, fourthArgCasted);

                execute(firsArgCasted, secondArgCasted, thirdArgCasted, bulkArgTypeByArgName);
            }
            when else {
                throw new MalformedCallException('Method not implemented');
            }
        }

        return null;
    }

    private void runMethodAsyncUpTo149Times(String className, String methodName, Map<String, List<Object>> bulkValuesByArgName, Map<String, String> bulkArgTypeByArgName) {
        this.bulkArgTypeByArgName = bulkArgTypeByArgName;
        for (Integer i = 0; i < 148; i++) {
            if (!hasMoreArgValues(bulkValuesByArgName)) {
                break;
            }
            Map<String, Object> methodArgs = getNextArgsChunk(bulkValuesByArgName);
            Async.execute(className, methodName, methodArgs);
        }
    }

    private void splitContextAndRepeat(String className, String methodName, Map<String, List<Object>> bulkValuesByArgName) {
        Async.execute('MethodAsyncBulkProcessor', 'execute', new Map<String, Object>{
                'obj' => className,
                'methodName' => methodName,
                'bulkValuesByArgName' => bulkValuesByArgName,
                'bulkArgTypeByArgName' => bulkArgTypeByArgName
        });
    }

    private Map<String, Object> getNextArgsChunk(Map<String, List<Object>> bulkArgs) {
        Map<String, Object> argsChunk = new Map<String, Object>();
        for (String argName : bulkArgs.keySet()) {
            Object argValue = bulkArgs.get(argName).remove(0);
            argsChunk.put(argName, argValue);
        }
        return argsChunk;
    }

    private Boolean hasMoreArgValues(Map<String, List<Object>> bulkArgs) {
        return !bulkArgs.get(
                new List<String>(bulkArgs.keySet())[0]
        ).isEmpty();
    }
}