# apex-async-method-call based on Platform Events

The small library provides a way to run apex methods asynchronously without limitations of future, queueable, 
batch or schedulable approaches.

### UPDATE: 18-Feb-2021
* Changed API names
* Removed not immediate PE invocations
* Implemented method for a bulk run of the async method (i.e., pass list with 500 ids and process each in the different context). To use, set Trigger bulk size to 1. It could be used in the Batch execute methods.
* Updated examples
* Added zip package to set MethodCallTrigger bulk size to 1 record (change_triggers_bulk.zip). Use workbench to deploy. Source deploy currently is not supported.