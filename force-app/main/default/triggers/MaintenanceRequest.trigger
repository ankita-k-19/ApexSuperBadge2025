trigger MaintenanceRequest on Case (before update, after update) {
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders

    switch on Trigger.OperationType {
        when  AFTER_UPDATE {

            MaintenanceRequestHelper.createNewMaintenanceRequests(Trigger.new,Trigger.oldMap);
            
        }
        
    }
}