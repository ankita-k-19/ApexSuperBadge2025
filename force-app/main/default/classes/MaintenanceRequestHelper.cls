public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders() {
        // TODO: Complete the method to update workorders
        
    }        
    


    public static void createNewMaintenanceRequests(Map<id,Case> newMaintenceRequest,Map<id,Case> oldnewMaintenceRequest)
    {
        Set<Id> oldKeys=oldnewMaintenceRequest.keySet();
        list<Case> maintenanceRequests=[Select 
                                            Id,
                                            Status,
                                            Type,Vehicle__r.Id,
                                            (Select Id from Equipment_Maintenance_Items__r) 
                                                from Case 
                                                where 
                                                Type IN ('Repair','Routine Maintenance') 
                                                AND id IN:oldKeys];


        Map<Id,Case> newRequests=new Map<Id,Case>();

        for(Case request:maintenanceRequests)   
        {
            if(request.Status!='Closed' && newMaintenceRequest.get(request.id).Status=='Closed')
            {
                newRequests.put(request.id,request);
                
            }
        }


        list<Case> insertNewCases=new list<Case>();


        for (Case r:newRequests)
        {

            Equipment_Maintenance_Item__c e=new Equipment_Maintenance_Item__c();
            


            Case c=new Case();
            c.Vehicle__c=r.Vehicle__c.Id;
            c.Type='Routine Maintenance';
            c.origin=r.origin;
            c.Subject='Routine Maintenance For'+r.Vehicle__c.Name;
            Date_Reported__c=system.Today();


        }




    }
}