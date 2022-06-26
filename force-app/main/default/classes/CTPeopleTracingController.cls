public with sharing class CTPeopleTracingController {

    public static List<People_Tracing__c> getTraces(String personId) {
         List<People_Tracing__c> traces;

        if(
            People_Tracing__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Person__c.fields.Name.isAccessible() 
        ) {
            traces = [SELECT Id, Person_1__c, Person_1__r.Health_status__c, 
                            Person_1__r.Token__c, Person_2__c, Person_2__r.Health_status__c, 
                            Person_2__r.Token__c, Contact_Date__c FROM People_Tracing__c 
                            WHERE Person_1__c =: personId OR  Person_2__c =: personId ORDER BY Contact_Date__c DESC];
        }

        return traces;
    }

      
    public static List<People_Tracing__c>  checkDuplicates(List<People_Tracing__c> newPeopleTraces) {
        //unique person ids
        Set<Id> personsId = new Set<Id>();

        for (People_Tracing__c trace: newPeopleTraces) {
            personsId.add(trace.Person_1__c);
            personsId.add(trace.Person_2__c);
        }

        // list duplicate records
        List<People_Tracing__c> duplicates = new List<People_Tracing__c>();

        // map id and set<id>
        Map<Id, Set<Id>> mapOfExistingRecords = new  Map<Id, Set<Id>>();

        List<People_Tracing__c> existingRecords;

         if(
            People_Tracing__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Person__c.fields.Name.isAccessible() 
        ) {
             existingRecords = [SELECT Id, Person_1__c, Person_2__c FROM People_Tracing__c 
                            WHERE Person_1__c IN :personsId OR  Person_2__c IN :personsId];
        }

        if (existingRecords != null && existingRecords.size() > 0) {

            for(People_Tracing__c trace : existingRecords) {
                if (!mapOfExistingRecords.containsKey(trace.Person_1__c)) {
                    mapOfExistingRecords.put(trace.Person_1__c, new Set<Id>());
                }

                // add person ids to map set
                mapOfExistingRecords.get(trace.Person_1__c).add(trace.Person_2__c);

                //Build map for person 2
                 if (!mapOfExistingRecords.containsKey(trace.Person_2__c)) {
                    mapOfExistingRecords.put(trace.Person_2__c, new Set<Id>());
                }

                // add person ids to map set
                mapOfExistingRecords.get(trace.Person_2__c).add(trace.Person_1__c);
            }

            // loop over existing records to find duplicates
            for(People_Tracing__c traceOp :  newPeopleTraces) {
                // check for duplicates in map
                if (mapOfExistingRecords.containsKey(traceOp.Person_1__c) 
                    && mapOfExistingRecords.get(traceOp.Person_1__c).contains(traceOp.Person_2__c) ||
                    mapOfExistingRecords.containsKey(traceOp.Person_2__c) 
                    && mapOfExistingRecords.get(traceOp.Person_2__c).contains(traceOp.Person_1__c) 
                    ) {
                    duplicates.add(traceOp);
                }
            }
        }

        return duplicates;
    }
}
