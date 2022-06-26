public with sharing class CTLocationTracingController {

    public static List<Location_Tracing__c> getVisitors(String locationId) {
         List<Location_Tracing__c> locations;

        if(
            Location_Tracing__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Person__c.fields.Name.isAccessible() 
        ) {
            locations =  [SELECT Id, Person__c, Location__c, Visit_Date__c, Person__r.Token__c, Person__r.Health_status__c 
                        FROM Location_Tracing__c WHERE Id =: locationId ORDER BY Visit_Date__c DESC];
        }
        return locations;
    }

    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds) {
        List<Location_Tracing__c> locations;

        if(
            Location_Tracing__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Person__c.fields.Name.isAccessible() 
        ) {
            locations =  [SELECT Id, Name, Person__c, Location__c 
                          FROM Location_Tracing__c 
                          WHERE Person__c IN :personIds 
                          AND Visit_Date__c = LAST_N_DAYS:10];
        }
        return locations;
    }

    public static List<Location_Tracing__c> getLocationsByLocationIds(Set<Id> locationIds) {
         List<Location_Tracing__c> locations;

        if(
            Location_Tracing__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Person__c.fields.Name.isAccessible() 
        ) {
            locations =  [SELECT Id, Person__c, Location__c 
                          FROM Location_Tracing__c 
                          WHERE Person__c IN :locationIds 
                          AND Person__r.Health_status__c = 'Green'
                          AND Visit_Date__c = LAST_N_DAYS:10];
        }
        return locations;
    }

    public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c>  newLocationTraces) {
        // store unique location ids
        Set<Id> locationIds = new Set<Id>();

        // store unique person ids
        Set<Id> personIds = new Set<Id>();

        for(Location_Tracing__c trace : newLocationTraces) {
            locationIds.add(trace.Location__c);
            personIds.add(trace.Person__c);
        }

        Map<Id, Set<Id>> mapOfExistingRecords = new  Map<Id, Set<Id>>();
        // query existing location tracing records
        List<Location_Tracing__c> existingRecords;

        if (
            Location_Tracing__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Person__c.fields.Name.isAccessible() 
        ) {
            existingRecords =  [SELECT Id, Person__c, Location__c FROM Location_Tracing__c WHERE Location__c IN :locationIds AND Person__c IN :personIds];
        }
            
        // List of duplicate records
        List<Location_Tracing__c> duplicates = new List<Location_Tracing__c>();

        if (existingRecords != null && existingRecords.size() > 0) {

            for(Location_Tracing__c trace : existingRecords) {
                if (!mapOfExistingRecords.containsKey(trace.Location__c)) {
                    mapOfExistingRecords.put(trace.Location__c, new Set<Id>());
                }

                // add person ids to map set
                mapOfExistingRecords.get(trace.Location__c).add(trace.Person__c);

                // loop over new location tracing records
                for(Location_Tracing__c traceOp :  newLocationTraces) {
                    // first check for location id
                    // if item found in map, then check for person in set
                    if (mapOfExistingRecords.containsKey(traceOp.Location__c) 
                        && mapOfExistingRecords.get(traceOp.Location__c).contains(traceOp.Person__c)) {
                            duplicates.add(traceOp);
                        }
                }
            }
        }

        return duplicates;
    }
}
