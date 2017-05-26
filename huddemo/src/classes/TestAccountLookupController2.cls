@isTest
public class TestAccountLookupController2 {
    
    static testMethod void accountLookup2() {
        Account acc = new Account(Name = 'Test 1');
        Insert acc;
        ApexPages.currentPage().getParameters().put('accName', 'Test 1');
        ApexPages.currentPage().getParameters().put('accNameFieldId', 'Test 1');
        ApexPages.currentPage().getParameters().put('accHiddenField',''+acc.id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        AccountLookupController2 alc = new AccountLookupController2(sc);
        
        PageReference searchTemp = alc.searchUsers();
        
        ApexPages.currentPage().getParameters().put('accName', 'Te');
        ApexPages.currentPage().getParameters().put('accNameFieldId', 'Te');
        ApexPages.currentPage().getParameters().put('accHiddenField',''+acc.id);
        
        ApexPages.StandardController sc2 = new ApexPages.StandardController(acc);
        AccountLookupController2 alc2 = new AccountLookupController2(sc2);
        
        PageReference searchTemp2 = alc2.searchUsers();
        alc2.accName = null;
        PageReference searchTemp3 = alc2.searchUsers();
        
    }
}