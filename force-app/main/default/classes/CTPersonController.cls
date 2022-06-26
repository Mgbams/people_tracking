public with sharing class CTPersonController {

    public static String getToken(String mobileNo) {
        Blob value = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', value);

        // Get the string value of hash
        return EncodingUtil.base64Encode(hash);
    }

    public static List<Person__c> getRecentHealthChanges() {
      List<Person__c> persons;
      
     if(
            Person__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Person__c.fields.Name.isAccessible() 
        ) {
            persons = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
        }
        return persons;
    }

   public static List<Person__c> searchPeople(String searchTerm) {
        searchTerm = searchTerm + '%';
        List<Person__c> persons;

        if(
            Person__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Person__c.fields.Name.isAccessible() 
        ) {
            persons =  [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c 
                FROM Person__c WHERE Name LIKE :searchTerm OR Mobile__c LIKE :searchTerm 
                OR  Token__c LIKE :searchTerm ORDER BY Status_Update_Date__c DESC NULLS LAST];
        }
        return persons;
    }

    public static Person__c getPersonById(String personId) {
       
        List<Person__c> persons;
        
        if(
                Person__c.SObjectType.getDescribe().isAccessible() &&
                Schema.SObjectType.Person__c.fields.Name.isAccessible() 
        ) {
                persons = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c WHERE Id =: personId ];
          }

        if (persons != null && persons.size() > 0) {
            return persons[0];
        }
        return null;
    }
   
}
