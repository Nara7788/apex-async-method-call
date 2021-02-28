public with sharing class DemoService implements Callable {

    public static void testDebugLogMethodAsyncRun() {
        Async.execute(
                'DemoService',
                'debugLog',
                new Map<String, Object>{
                        'message' => 'test message'
                });
    }

    public static void testDebugLogMethodAsyncBulkRun() {
        List<String> bulkValues = new List<String>();
        for (Integer i = 0; i < 200; i++) {
            bulkValues.add(String.valueOf(i + 1));
        }

        new MethodAsyncBulkProcessor().execute(
                'DemoService',
                'debugLog',
                (Map<String, List<Object>>) new Map<String, List<String>>{
                        'message' => bulkValues
                },
                new Map<String, String>{'message' => 'List<String>'}
        );
    }

    public static void testComplexArgumentsMethodAsyncRun() {
        Async.execute(
                'DemoService',
                'complexArguments',
                new Map<String, Object>{
                        'firstName' => 'John',
                        'knownTechnologies' => new List<String>{
                                'Java', 'JS'
                        }
                });
    }

    public static void testComplexArgumentsMethodAsyncBulkRun() {
        List<String> bulkNameValues = new List<String>();
        for (Integer i = 0; i < 153; i++) {
            bulkNameValues.add('John ' + String.valueOf(i + 1));
        }

        List<List<String>> bulkTechnologyValues = new List<List<String>>();
        for (Integer i = 0; i < 153; i++) {
            bulkTechnologyValues.add(new List<String>{
                    'Apex', 'C#'
            });
        }

        new MethodAsyncBulkProcessor().execute(
                'DemoService',
                'complexArguments',
                (Map<String, List<Object>>) new Map<String, List<Object>>{
                        'firstName' => bulkNameValues,
                        'knownTechnologies' => bulkTechnologyValues
                },
                new Map<String, String>{
                        'firstName' => 'List<String>', 'knownTechnologies' => 'List<List<String>>'
                }
        );
    }

    public void debugLog(String message) {
        System.debug(message);
    }

    public void complexArguments(String firstName, List<String> knownTechnologies) {
        System.debug('firstName ' + firstName);
        System.debug('knownTechnologies ' + knownTechnologies);
    }

    public Object call(String methodName, Map<String, Object> args) {
        switch on methodName {
            when 'debugLog' {
                Object firstArg = args.get('message');
                String firsArgCasted = (String) CastService.cast(firstArg, String.class);
                debugLog(firsArgCasted);
            }
            when 'complexArguments' {
                Object firstArg = args.get('firstName');
                Object secondArg = args.get('knownTechnologies');
                String firsArgCasted = (String) CastService.cast(firstArg, String.class);
                List<String> secondArgCasted = (List<String>) CastService.cast(secondArg, List<String>.class);
                complexArguments(firsArgCasted, secondArgCasted);
            }
            when else {
                throw new MalformedCallException('Method not implemented');
            }
        }

        return null;
    }
}