public class ContactsByAccount_extension {

    public ContactsByAccount_extension(ApexPages.StandardController controller) {

    }
    
    public Map<String,contactosListWrapper> getContactsByAccount(){
    
      List<Contact> result = [SELECT Account.name, Title, Name, Email FROM Contact ];
    
      // Group Contacts by Account                                
      Map<String,contactosListWrapper> contactsByAccount = new Map<String,contactosListWrapper>();
      for(Contact cont: result){
        if(null == cont.Account.name) continue;
        contactosListWrapper empresa = contactsByAccount.get(cont.Account.name);
        if(null == empresa){
            contactsByAccount.put(cont.Account.name, new contactosListWrapper(new List<contact>()) );    
        }
        contactsByAccount.get(cont.Account.name).contactList.add(cont);
      }
      
      return contactsByAccount;
    }
    
   // List of contacts and details  
   class contactosListWrapper {
       
       public List<Contact> contactList {get; set;}
       
       public Integer numOfContacts {
          get{
            return contactList.size();
          }
          set;
       }
       
       public Id firstOfList{
          get{
            return contactList[0].Id;
          }
          set;
       }
             
       public contactosListWrapper(List<contact> listContacts){
           contactList = listContacts;
        }
    }   
}