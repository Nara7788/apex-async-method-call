public with sharing class DemoService implements Callable {

    public void sendNotifications(Map<Integer, String> userMessages) {
        System.debug('Notification is sent');
    }

    public void sendNotificationsAsync(Map<Integer, String> userMessages) {
        Async.execute(
                DemoService.class,
                'sendNotifications',
                new Map<String, Object>{
                        'userMessages' => userMessages
                });
    }

    public void calculatePiNumber(Integer piSigns) {
        System.debug('Long calculations');
    }

    public void calculatePiNumberAsync(Integer piSigns) {
        Async.execute(
                DemoService.class,
                'calculatePiNumber',
                new Map<String, Object>{
                        'piSigns' => piSigns
                });
    }


    public Object call(String methodName, Map<String, Object> args) {
        switch on methodName {
            when 'sendNotifications' {
                Object firstArg = args.get('userMessages');
                Map<Integer, String> firsArgCasted = (Map<Integer, String>) Async.cast(
                        firstArg,
                        Map<Integer, String>.class
                );
                sendNotifications(firsArgCasted);
            }
            when 'calculatePiNumber' {
                Object firstArg = args.get('piSigns');
                Integer firstArgCasted = (Integer) Async.cast(firstArg, Integer.class);
                calculatePiNumber(firstArgCasted);
            }
            when else {
                throw new MalformedCallException('Method not implemented');
            }
        }

        return null;
    }

    public class MalformedCallException extends Exception {

    }
}