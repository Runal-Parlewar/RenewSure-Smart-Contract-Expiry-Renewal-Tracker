import { LightningElement, wire, track } from 'lwc';
import getExpiringContracts from '@salesforce/apex/ContractsDashboardController.getExpiringContracts';
import getRenewalValues from '@salesforce/apex/ContractsDashboardController.getRenewalValues';

export default class ContractsDashboard extends LightningElement {
    @track contractData = [];
    @track renewalData = [];
    
    @wire(getExpiringContracts)
    wiredContracts({ error, data }) {
        if(data){
            this.contractData = data.map(item => ({
                status: item.Status_c__c,
                count: item.total
            }));
        } else if(error){
            console.error(error);
        }
    }
    
    @wire(getRenewalValues)
    wiredRenewals({ error, data }){
        if(data){
            this.renewalData = data.map(item => ({
                type: item.	Renewal_Type__c,
                totalValue: item.totalValue
            }));
        } else if(error){
            console.error(error);
        }
    }
}
