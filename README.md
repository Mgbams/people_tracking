## IMPORTANT LINKS

- [Salesforce Setup](https://mgbams-dev-ed.lightning.force.com/lightning/setup/SetupOneHome/home)
- [Trail Head](https://trailhead.salesforce.com/fr/today/new_user)
- [Salesforce Signup Page](https://developer.salesforce.com/signup)
- [Salesforce Cli Download](https://developer.salesforce.com/tools/sfdxcli)
- [Salesforce Youtube APEX Hours Tutorial](https://www.youtube.com/watch?v=fpKZZ3kT-iU&list=PLaGX-30v1lh1e8roeCUumUEel5ukdPubj&index=3)
- [Salesforce SOQL and SOSL TUTORIAL](https://developer.salesforce.com/docs/atlas.en-us.232.0.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_sosl_intro.htm)
- [Salesforce Query Plan Tool](https://help.salesforce.com/s/articleView?id=000334796&type=1)
- [Salesforce APEX Hours DML and Database methods](https://www.apexhours.com/dml-statement-vs-database-methods-in-salesforce/)
- [Salesforce APEX DML and Database methods](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_dml_database.htm)
- [Apex Triggers](http://www.apexhours.com/demystifying-apex-triggers/)
- [Trigger Framework](https://salesforcenextgen.com/apex-trigger-framework/)

// Date formats in soql queries
- [Date formats in APEX](https://developer.salesforce.com/docs/atlas.en-us.216.0.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_dateformats.htm?language=en)


HOW TO ACCESS BUILT IN OBJECTS
==================================
1. click on the gear icon => Configurations => Géstionnaire d'objets
Select the table you're interested in.
Click on **champs et relations** on the left side panel to reveal more info about the object.

APEX EXXTENSIONS IN VSCODE
===============================

1. Salesforce Extension pack

**NOTE:** 2 and 3 comes automatically when you install **salesforce Extension pack extended** package in vscode.
2. Apex Replay Debugger => Helps to add breakpoints for debugging
3. Apex PMD => Helps you maintain a good coding convention

IN VSCODE
CREATING PROJECT AND CONNECTING IT WITH SALESFORCE
==========================================================
1a. Click Extensions from the left panel. Search for **Salesforce Extension pack** and install it.
1b. Go to: https://developer.salesforce.com/tools/sfdxcli
Download and install it. THEN RESTART YOUR VSCODE.

2. View => commande palette => Type SFDX:
Select **SFDX: Create project with manifest**
Enter name for your project.

2. View => commande palette => Type SFDX:
Select **SFDX: Authorize an org => Select Production**
Enter a name for it e.g apexdevsession
It will open salesforce login page for you to login.

**NOTE**: ctrl + shift + p => It opens the command palette in VsCode.
A. click on manifest -> open package.xml -> right-click in the opened 
   package.xml and click on **Retrieve source in Manifest from Org**.

CREATING APEX CLASSES IN VSCODE
===================================
1a. Press ctrl + shift + p => It opens the command palette in VsCode.
1. Type **create** on the command palette and select **create Apex classes**. Enter the class name and press Enter.
2. Right-click on the class you just create -> click on **Deploy this source to org**.

**NOTE:** To Execute an SOQL query
======================================
1. Open scripts -> account.soql
2. Highlight the query you want to execute using your mouse
3. Press ctrl + shift + p => This opens command palette
4. Type **Execute** in the commande palette
5. From the displayed Execute options, select **SFDX: Execute SOQL Query with Currently Selected Text**
6. Select **REST API**

**NOTE:** To Execute codes in the scripts -> apex folder
=========================================================
1. Open scripts -> apex -> fileName.apex
2. Highlight the code you want to execute using your mouse
3. Press ctrl + shift + p => This opens command palette
4. Type **Execute** in the commande palette
5. From the displayed Execute options, select **Execute Anonymous Apex with Currently Selected Text**.

DEBUG LOG
==============
Il vous aide à suivre les événements qui se produisent dans votre journal.

Le journal de débogage contient des informations telles que: 
1. Modifications de la base de données
2. Appels HTTP
3. Erreurs Apex
4. Ressources utilisées par Apex
5. Processus de workflow automatisés.

LOGGING LEVEL
*************
1. ERROR
2. WARN
3. INFO
4. DEBUG
5. FINE
6. FINER
7. FINEST

SETTING UP DEBUGGING
1. Serach for débogage OR debug(english)
2. Under Environnements -> Journaux -> Journaux de débogage
3. Click on nouveau OR new
4. 

SOQL
============
Salesforce Object Query Language(Langage de requête d'objet Salesforce).
You can query data from Salesforce using SOQL in -
1. Apex Code
2. Developer Console
3. Salesforce REST and SOAP APIs
4. Salesforce CLI

AGGREGATE QUERIES METHODS
==========================
1. COUNT
2. AVERAGE
3. SUM
4. MIN
5. MAX

**NOTE:** You can use Aggregate functions with GROUP BY. BUT you cannot use
aggregate functions with WHERE clause.

List<Opportunity> lsOpp = [SELECT Id, Name FROM Opportunities];

**NOTE:** SOQL query always returns a List<SObject>*. In Apex, create a List<ObjectType> for the object
specified in the query. Use for...loop for iteraring over the 
results of a SOQL query.

E.g
****
for (Account a: [SELECT Id, Name FROM Account] ) {
   // Your Code
}

### SOSL
SOSL => Salesforce object search language(Langage de recherche d'objet Salesforce).
It allows you perform a search operation on multiple objects at a time.
SOSL returns List<List<SObject>> as a result.
E.g
```SQL
    List<List<SObject>> searchList = [FIND 'Joe*' IN ALL FIELDS RETURNING Account(Id, Name), Lead];

    Account[] accs = searchList[0];
    Lead[] leads = searchList[1];
```

TO ENABLE QUERY PLAN
***********************
This helps you monitor the cost of your query. If your query is costly, then
you need to optimise it for better performance.
1. Open developer console.
2. click on help -> Preferences
Then toggle **Enable Query Plan** to True and click the Save Button.

### DML OPERATIONS
DML => Data Manipulation Language (Langage de manipulation des données).
1. insert, update, delete, upsert, merge, undelete

E.g
****
```SQL
Opportunity opp = new Opportunity(
	Name = 'New Opportunity ApexHours 0213',
	CloseDate = Date.today(),
	Amount = 1000,
	StageName = 'Prospecting',
	AccountId = '001342567829'
);

insert opp;
```

NOTE, DML uses an atomic approach. i.e it behaves as a transaction and only inserts
data if all the sql requetes are valid Else it makes a RollBack.

**BUT** If you don't care about the errors and you want to insert successful
queries and skip the unsuccesful requetes, then use the Database equivalent
of the DML requetes e.g
1. Database.insert([SObject | List<SObject>], [Boolean allOrNone]);
2. Database.update([SObject | List<SObject>], [Boolean allOrNone]);
3. Database.delete([SObject | List<SObject>], [Boolean allOrNone]);
4. Database.upsert([SObject | List<SObject>], [Boolean allOrNone]);
5. Database.merge([SObject | List<SObject>], [SObject | List<SObject>], [Boolean allOrNone]);
6. Database.undelete([SObject | List<SObject>], [Boolean allOrNone]);

E.g
*****
```SQL
Opportunity opp1 = new Opportunity(
	Name = 'New Opportunity ApexHours 0213',
	CloseDate = Date.today(),
	Amount = 1000,
	StageName = 'Prospecting',
	AccountId = '001342567829'
);

Opportunity opp2 = new Opportunity(
	Name = 'New Opportunity ApexHours 223',
	CloseDate = Date.today(),
	Amount = 5000,
	StageName = 'Marketing',
	AccountId = '221342568764'
);

List<Opportunity> lstOpp = new List<Opportunity>{opp1, opp2};
insert lstOpp; // It uses atomicity
Database.insert(lstOpp, false); // No atomicity because of the false field
Database.SaveResult[] sr = Database.insert((lstOpp, false);

for (Databse.SaveResult val : sr) {
  System.debug('Result - ' + val.isSuccess());
}
```

**NOTE:** 
1. The return type of Database.insert = Database.SaveResult

Setting a save point in a query
================================
To have a transaction control, we use a SavePoint and also we surround 
the query that has the validation rule in a try catch block where we call
a rollback on the database and pass the saved point of our program as its parameter.
E.G
****
System.Savepoint spt = Database.setSavePoint();

USAGE
*****

```SQL
Opportunity opp2 = new Opportunity(
	Name = 'New Opportunity ApexHours 223',
	CloseDate = Date.today(),
	Amount = 5000,
	StageName = 'Marketing',
	AccountId = '221342568764'
);
insert opp2;

// saves the state of the query at this point
System.Savepoint spt = Database.setSavePoint(); 

try {
	Contact con = new Contact(LastName = 'Kings');
	insert con;
} catch(Exception ex) {
	Database.rollback(spt);
}
```

TRIGGERS
===========
Trigger is a procedure in database which automatically invokes 
whenever a special event in database occurs.
Types
*****
1. before
 a. insert
 b. update
 c. delete

2. after
 a. insert
 b. update
 c. delete
 d. undelete

Variables
*********
1. isExecuting, isInsert, isUpdate, isDelete, isBefore, 
   isAfter, new(only available in insert, update, undelete. it is only modified in before triggers), 
   newMap(only available in before update, after insert, after update, after undelete triggers), 
   old(only available in update and delete triggers), 
   oldMap(only available in update and delete triggers), operationType(Returns an enum of type System.TriggerOperation), size

**NOTE** System.TriggerOperations are BEFORE_UPDATE, BEFORE_INSERT, BEFORE_DELETE, AFTER_INSERT, 
AFTER_UPDATE, AFTER_DELETE, AFTER_UNDELETE

EXAMPLES OF TRIGGERS
********************
1. To create a trigger, open developer console. Click file -> new -> apex trigger
Give it a name and choose the class it should work on and then click Submit. 
You'll have something similar to the below code.

```SQL
trigger accountTrigger on Account (before insert, before update) {
    if (Trigger.isBefore && Trigger.isInsert) {
        System.debug('I am in before insert context');
    }
    
    if (Trigger.isUpdate) {
	
	if (Trigger.isBefore) {
		for (Account acc: Trigger.new) {
        		System.debug('Newame ' + acc.Name);
			System.debug('Old Name ' + Trigger.oldMap.get(acc.Id).Name);
		}
	}
    }
}


ex2.
*****

trigger contactEmailSender on Contact (before insert) {
    List<Contact> contactEmailList = new List<Contact>();
    
    for (Contact con: Trigger.new) {
	if (con.HasEmailAddress_c) {
	   contactEmailList.add(conn);
        }
    }

    SendEmailHelper.sendemail(contactEmailList);
    
}

ex3.
*****

trigger MileageTrigger on Mileage_c (before insert, before update) {
    Set<ID> ids = Trigger.newMap.keySet();
    List<User> c = [SELECT Id FROM user WHERE mileageid_c in :ids];
}
```

TRIGGER FRAMEWORKS
*******************
1. Trigger Handler Pattern
2. Trigger Framework using a virtual class
3. Trigger Framework using an interface
4. An architecture framework to handle triggers

UNIT TESTS
************
What to test
=============
1. Apex Trigger
2. Apex Class Handler / Helper, WebService, Apex REST, SOAP
3. Custom Controller
4. VF Page
5. Apex Batch / Queueable / Future Method

HOW TO CREATE A TEST
*********************
1. open developer console
2. click file -> new -> Apex Class
3. Give the class a name
4. When the class is created, annotate it with @isTest

Example
========
```SQL
@isTest
public class First {

    @TestSetup
    static void setup() {
        // create common test accounts
        List<Account> testAccts = new List<Account>();
        for (Integer i = 0; i < 200; i++) {
            testAccts.add(new Account(Name = 'TestAcct' + i, Industry = 'Education', 
                                      Rating = 'Hot', Phone = '998765433' + i));
        }
        
        insert testAccts;
    }

    @istest
    static void trialTest() {
        
    }

    @istest
    static void method1Test() {
	// update
        Account acct = [SELECT Id FROM Account WHERE Name = 'TestAcct10' LIMIT 1];
	acct.phone = '555-1212';
	update acct;
	
	// Verify
	System.assertEquals('555-1212', acct.phone);
	System.assertNotEquals(null, acct.phone);

	// delete
        Account acct1 = [SELECT Id FROM Account WHERE Name = 'TestAcct5' LIMIT 1];
	delete acct1;
    }
}
```

WAYS TO EXECUTE TESTS
=======================
A. FIRST APPROACH
1. clcik your gear icon
2. in the search bar, type test
3. Select Exécution du test Apex OR Apex test execution

B. Click on Run test at the far right of the test 
you wrote in developer console.

**NOTE:** Always use seeAllData = false;
**NOTE:** You cannot use Test.startTest and Test.stopTest in a method that already
uses @isTest annotation

**IMPORTANT**
1. @TestVisible: To access private member in Test Class
2. Test.LoadData: Creating Test data Without code
3. System.RunAs: Testing user context
4. Test.startTest and Test.stopTest: Running code within limit

How to use Test.loadData
************************
1. Create a static resource i.e click configurations OR settings. In
the search box, type statiques OR static. Then click on Ressources statiques
OR static resources. Click on New to create a new static resources.

Test.loadData(Schema.sObjectType, staticResourceName);
Example:
========
List<Account> sobjectList = (List<Account>) Test.loadData(Account.sObjectType, 'testAccounts');
System.assertEquals(3, sobjectList.size());

ANNOTATIONS
===============
1. @deprecated
2. @AuraEnabled(cacheable = true) i.e @AuraEnabled => annotation; (cacheable = true) => modifiers
3. @Future
4. @InvocableVaraible
5. @InvocableMethod
6. @IsTest
7. @ReadOnly
8. @RemoteAction
9. @TestSetup
10. @TestVisible
à
USING PROCESS BUILDER
======================
1. type process
2. click on Générateur de processus(Process builder)
3. click nouveau (new)

TEST
===========
A test method must be static and must not return a value. 
Also its visibility must be public or global.

DATE LITERALS
==================
[Date Literals](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select_dateformats.htm)

e.g
1. LAST_WEEK, TOMORROW, NEXT_MONTH, THIS_MONTH, NEXT_WEEK
2. LAST_N_DAYS:n e.g SELECT Id FROM Account WHERE CreatedDate = LAST_N_DAYS:365
3. N_DAYS_AGO:n e.g SELECT Id FROM Opportunity WHERE CloseDate = N_DAYS_AGO:25

### Relationships in an object
1. it could be either lookup or master detail relationship.
To see it click on champs et relations of the child object. under types des donnes, 
you'll find the type of relationship. click on the name of the relationship to get the child relationship name
E.g Nom de la relation enfant: Contacts. Then use the child relationship name in a query E.g référence(Account) OR lookup(Account).

Query example of relationship in a PARENT to CHILD Relationship

```SQL
SELECT Name, age, (SELECT ContactAddress, Phone FROM Contacts)
FROM Account
```

BUT for custom object, you'll have something similar to this:

```SQL
    SELECT Name, age, (SELECT ContactAddress, Phone FROM Contacts__r)
    FROM Account__c
```
#### LIMITATIONS OF QUERY FROM a PARENT to CHILD Relationship

1. Maximum of 20 objects possible in the query
2. You can only go one level deeep in making the relationship. i.e There will alwys be one parent.
A child object cannot be used as a parent to another child component in a parent to child query.


#### Query example of relationship in a CHILD TO PARENT Relationship
In this case, we don't focus on the child relationship name(Nom de la relation enfant) 
but instead on the field name(Nom du champ) e.g School as in the example below.
CHILD TO PARENT Relationship supports up to 5 levels of parents records.
It also supports up to 55 related objects in a query.

E.g: 1
=========
```SQL
SELECT Name, 
       RollNumber, 
       School.Name, 
       School.RegistrationNumber
FROM STUDENT

E.g: 2
========
SELECT Name, 
       Phone, 
       Departement,
       Account.Name, 
       Account.Website,
       Account.Owner.Name
FROM Contact
```

**NOTE:** In example 2, Contact is the child of Account and Account is the child of Owner.
BUT FOR A CUSTOM OBJECT, DON'T FORGET TO ADD __r TO THE RELATIONSHIP FIELD NAME 

E.g: 3
========
```SQL
SELECT Name, 
       Price__c, 
       Author__r.Name, 
FROM Book__c

Looping through a map
======================

Map<Id, Account> accounting = new Map<Id, Account>([SELECT Name, Phone FROM Account]);

for (Account accountsMap: accounting.values()) {

}
```

Bigger example
===============
```SQL
List<Contact> contacts = [SELECT Account.Name, Account.Rating, Name, Department, Title, (SELECT CaseNumber, Subject FROM Cases WHERE IsClosed = false) FROM Contact WHERE Account.Rating = 'Hot' AND Department = 'Technology' ORDER BY Name DESC];

for (Contact con: contacts) {
   System.debug(con.Name + ' ' + con.Account.Name + ' ' + con.Account.Rating);

   for (Case caseObj: con.Cases) {
       System.debug(caseObj.CaseNumber);
   }
}
```

BINDING VARIABLES IN SOQL
===========================
We use colon(:) while creating a bind variable e.g

Ex1:
*****
```SQL
    Set<Id> accountIds = new Set<Id>();
    [SELECT Id, Name, Rating FROM Account WHERE Id IN :accountIds];

    Ex2:
    *****
    String leadName = 'XYZ Corp';
    [SELECT Id, Name FROM Lead WHERE Name =:leadName];
```

**NOTE** We can only use Binding variables after the where clause and not for the field names.

DYNAMIC SOQL QUERIES
=====================
You can build your SOQL queries at runtime in apex code dynamically.
Dynamic SOQL enables you to create more flexible applications.

Example
**********
```SQL
String dynQuery = 'SELECT Id, Name FROM Account';

if (accountType == 'Red') {
  dynQuery += 'WHERE Rating = \'Hot\' AND Amount > 100,000';
}

List<Account> accounts = Database.query(dynQuery);
```

**NOTE** Dynaic query does not use square bracket for its query. INSTEAD, it uses
Database.query(queryParameter);

DML
====
**NOTE**: In Database Methods no exception is thrown. instead you get a result array.
In DML Statements you get an exception if a query fails.

Database Methods								DML Statements
*******************						       	       *****************
1.Database.SaveResult[] srList = Database.insert(accList, false);         	insert accList 

GET DELETED DATA
=================
Add ALL ROWS to your query to get also the deleted queries
E.g
***
```SQL
List<Account> allAccounts = ['SELECT Id, Name FROM Account ALL ROWS'];

/* Get only deleted accounts */
List<Account> deletedAccounts = ['SELECT Id, Name FROM Account WHERE isDeleted = true ALL ROWS'];
```

**NOTE** If you're using SObject as the type of your variable, then
you can access contents using get and getSobject() E.g  book.get('Name') and .getSObject('Author__r').get('Name');

You can visit the below link for more details:
[Apex methods](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_sobject.htm)


### TYPE CLASS
This helps us replace the new keyword during object instantiation.
Make sure you type cast the instantiation when you're using Type for object
instantiation. Example is shown below.
**NOTE**: To add content to an object that is type casted as SObject,
You use the method put and you give a 
key value pair of your content as shown below.

E.g
===
```SQL
    SObject acctList = (SObject) Type.forName('Account').newInstance();
    acctList.put('Name', 'Sample SObject Account');
    acctList.put('Phone', '7655443322');
    insert acctList;
```

You can visit the below link for more info:
[Apex methods](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_type.htm)

### LIMITS CLASS
1. getDMLStatements() => returns the number of DML Statements.
2. getHeapSize() => returns amount of memory(in bytes) that has been used.
You can check more information in the below link:
[Apex System methods limits](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_limits.htm)

```SQL
    List<Account> accounts = [SELECT Id, Type FROM Account];
    while(1 == 1) {
    if (Limits.getHeapSize() * 2 >= Limits.getLimitHeapSize() ) {
        break;
    }

    List<Account> dupAccounts = accounts;
    }
```


### CRYPTO CLASS
[Crypto class](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_classes_restful_crypto.htm)

generateDigest(algorithmName, input)

ENCODING UTIL CLASS
====================
[Encoding util](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_classes_restful_encodingUtil.htm)


**NOTE:** the command **Refresh SobjectDefinitions** and then select **All SObjects** in the vs code palette 
helps you fetch your objects.


### HANDLING THE ERROR: Validate CRUD permission before SOQL/DML

Visit: [Soql Validation](https://www.sfdcstop.com/2020/03/validate-crud-permission-before-soqldml.html)

```SQL
public static List<Person__c> getRecentHealthChanges() {
      List<Person__c> persons;
      
     if(
            Person__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Person__c.fields.Name.isAccessible() &&
            Schema.SObjectType.Person__c.fields.Phone.isAccessible()
        ) {
            persons = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC LIMIT 100];
        }
        return persons;
}
```

### AGGREGATE FUNCTIONS

The result type of an aggregate function is an AggregateResult[].
**NOTE**: Always use HAVING on an aggregated field to filter results from an aggregate function. In this case, don't use WHERE.
An example of an aggregate query is as shown below:

SELECT StageName, LeadSource, COUNT(Id), MAX(Amount), MIN(Amount), AVG(Amount), 
SUM(Amount) FROM Opportunity 
GROUP BY StageName, LeadSource HAVING SUM(Amount) > 800000

E.g1
*****
Using aggregate functions to get values in apex code.

```SQL
AggregateResult[] groupedResults = [SELECT StageName, AVG(Amount), MAX(Amount) FROM Opportunity];

Double avgAmount = Double.valueOf( groupedResults[0].get('expr0'));
Double maxAmount = Double.valueOf( groupedResults[0].get('expr1'));

for (AggregateResult result: groupedResults ) {
  System.debug('StageName: ' + result.get('stageName') + 
	' Max Amount: ' + result.get('expr0') + 
	' Min Amount: ' + result.get('expr1') + 
	' Avg Amount: ' + result.get('expr2'));
}

/*OR YOU CAN USE ALIAS FOR THE COLUMN NAMES AS SHOWN BELOW*/
==============================================================
AggregateResult[] groupedResults = [SELECT StageName, AVG(Amount) avgAmount, 
                                    MAX(Amount) maxAmount, MIN(Amount) minAmount 
                                    FROM Opportunity];

Double avgAmount = Double.valueOf( groupedResults[0].get('avgAmount'));
Double maxAmount = Double.valueOf( groupedResults[0].get('maxAmount'));
Double minAmount = Double.valueOf( groupedResults[0].get('minAmount'));

for (AggregateResult result: groupedResults ) {
  System.debug('StageName: ' + result.get('stageName') + 
	' Max Amount: ' + result.get('maxAmount') + 
	' Min Amount: ' + result.get('minAmount') + 
	' Avg Amount: ' + result.get('AvgAmount'));
}
```
### ADDING ERROR TO TRIGGERS USING THE METHOD addError()
```sql
trigger LeadTrigger on Lead (before insert, before update, after update) {
    for (Lead leadRecord: Trigger.new) {
        if (String.isBlank(leadRecord.LeadSource)) {
            leadRecord.LeadSource = 'Other';
        }

         if (String.isBlank(leadRecord.Industry) && Trigger.isInsert) {
            leadRecord.addError('The industry field cannot be blank');
            leadRecord.Industry.addError('The industry field cannot be blank'); // Thrown on the industry field
        }
    }
}
```

### Trigger Context Variables
Apex triggers defines implicit variables from System.Trigger class which help you to control your trigger logic. E.g
1. isInsert, isUpdate, isDelete, isUndelete, isBefore, isAfter
2. new - List of new versions of records. Available in before insert, after insert, before update, after update, after undelete  e.g
Trigger.new is same as List<SObject>
3. newMap - Map of Id and new versions of records. Available in after insert, before update, after update, after undelete. e.g
Trigger.newMap is same as Map<Id, SObject>
4. old - List of old versions of records. Available in before update, after update, before delete, after delete  e.g
Trigger.old is same as List<SObject>
5. oldMap - Map of Id and old versions of records. Available in before update, after update, before delete, after delete. e.g
Trigger.oldMap is same as Map<Id, SObject>
6. isExecuting - Return true if current context for the apex code is trigger
7. size - The total number of records in a trigger invocation, both old and new.
8. operationType - Return an enum corresponding to the current operation. Possible values are:
BEFORE_INSERT, AFTER_INSERT, BEFORE_UPDATE, AFTER_UPDATE,BEFORE_DELETE, AFTER_DELETE, AFTER_UNDELETE, 

