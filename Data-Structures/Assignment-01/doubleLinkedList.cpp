#include <iostream>
#include <cstring>
using namespace std ;

class Employee{
 char name[20];
 int id;
 public:
 Employee(){
    id = 0;
    strcpy(name , "No Name");
 }
 Employee( char* name , int id){
    this-> id= id;
    strcpy(this->name , name);
 }
 void setId(int id){
    this->id = id;
 }  
 void setName(char* name){
    strcpy(this->name , name);
 }
 int getId(){
    return id;
 }
 char* getName(){
    return name;
    }
};
Employee fillEmployee();
void printEmployee(Employee emp);
Employee fillEmployee(){
    Employee emp;
    char name[20];
    int id;
    cout << "Enter Employee Name: ";
    cin >> name;
    cout << "Enter Employee ID: ";
    cin >> id;
    emp.setName(name);
    emp.setId(id);
    return emp;
}

void printEmployee(Employee emp){
    cout << "Employee Name: " << emp.getName() << endl;
    cout << "Employee ID: " << emp.getId() << endl;
}

class Node{
    public:
    Employee emp ;
    Node* pNext ; 
    Node* pPrev ;
    
    Node(Employee emp){
        this->emp = emp ;
        pNext = NULL ;
        pPrev = NULL ;
    }
};

class DoubleLinkedList{
    Node* pHead;
    Node* pTail;
    public:
    DoubleLinkedList(){
        pHead = NULL ;
        pTail = NULL ;
    }
    int addNode(Employee emp);
    int insertNode(Employee emp, int loc);
    Node* searchNodeById(int id);
    Node* searchNodeByName(char* name);
    int deleteNode(int loc);
    void freeList();
    void printList();
};
void DoubleLinkedList::freeList(){
    Node* temp;
    while(pHead != NULL){
       pHead = pHead->pNext;
       delete (temp);
       temp = pHead;
    }
    pTail = NULL;
}

int DoubleLinkedList::deleteNode(int loc){
    Node *temp;
    temp= pHead;
    int deleted = 0;
    if(pHead!=NULL){ // there's a list

        if(loc ==0){
            if(pHead == pTail){//only one node exists
                pHead =pTail = NULL;
                deleted =1 ;
                delete (temp);
            }
            else{
              pHead = pHead->pNext  ;    
                pHead->pPrev = NULL;
                deleted =1 ;
                delete (temp);
            }
        }
        else{
            for(int i = 0 ; i <loc && temp; i++){
                temp = temp->pNext;
            }
            if(temp!=NULL){
                if(temp == pTail){  //the last node
                pTail = pTail->pPrev;
                pTail->pNext = NULL;
                deleted =1 ;
                delete (temp);
            }
            else{   //middle
                    temp->pPrev->pNext = temp->pNext;
                   temp->pNext->pPrev = temp->pPrev;
                     deleted =1 ;
                     delete (temp);
            }
            }

        }
      
        }return deleted;
}
void DoubleLinkedList::printList(){
    Node* temp = pHead;
    while(temp!=NULL){
        printEmployee (temp->emp);
        temp = temp->pNext;
    }

}
int DoubleLinkedList::addNode(Employee emp){
    int added= 0;
    Node* ptr = new Node(emp);
    if(ptr!=NULL){ //node created
        added = 1;
        if(pHead == NULL){ //no list
            pHead = pTail = ptr;
        }
        else{
            pTail->pNext = ptr;
            ptr->pPrev = pTail;
            pTail = ptr;
        }

    } 
    return added;
}
int DoubleLinkedList::insertNode(Employee emp, int loc){
    int inserted = 0;
    Node* ptr = new Node(emp);
    if(ptr!=NULL){// node created
        inserted = 1;
        if(pHead==NULL){//no list
            pHead = pTail = ptr;
         }
        else{ //there's a list
            if(loc==0){
                pHead->pPrev = ptr;
                ptr->pNext= pHead;
                pHead = ptr;
            }
            else{//middle or last
                Node *temp;
                temp = pHead;
                for(int i = 0; i<loc-1 && temp ; i++){
                    temp = temp->pNext;
                }
                if(temp == pTail || temp == NULL){//last (last index or non-existing index)
                    pTail->pNext = ptr;
                    ptr->pPrev = pTail;
                    pTail = ptr;
                }
                else{//middle
                    temp->pNext->pPrev = ptr;
                    ptr->pNext = temp->pNext;
                    temp->pNext = ptr;
                    ptr->pPrev = temp;
                }
            }
        }
    }
    return inserted;
}

Node* DoubleLinkedList:: searchNodeById(int id){
    Node* temp;
    temp = pHead;
    while(temp->emp.getId()!= id && temp!=NULL){
        temp = temp->pNext;
    }
    return temp;
}


Node* DoubleLinkedList:: searchNodeByName(char* name){
    Node*temp;
    temp = pHead;
    while(strcmp(temp->emp.getName(), name)!=0 && temp!=NULL){
        temp = temp->pNext;
    }
    return temp;
}


int main(){
    DoubleLinkedList list;
     int choice;
    do{
        
        cout<<"Enter your choice : "<< endl;
        cout<<"1. Add Node "<<endl ;
        cout<<"2. Insert Node "<<endl ;
        cout<<"3. Search by ID "<<endl ;
        cout<<"4. Search by Name "<<endl ;
         cout<<"5. Print List "<<endl ;
          cout<<"6. Delete List "<<endl ;
          cout<<"7.Delete Node "<<endl ;
         cout<<"8. Exit "<<endl ;

         cin>> choice ;
         if(choice ==1){
            Employee emp = fillEmployee();
            list.addNode(emp);
         }
         else if(choice ==2){
            Employee emp = fillEmployee();
            int loc;
            cout<<"Enter location to insert : ";
            cin>> loc ;
            list.insertNode(emp, loc);
         }
       else if(choice ==3){
        int id ;
        cout << "Enter ID to search : ";
        cin >> id ;
        Node* temp = list.searchNodeById(id);
        if(temp!=NULL){
            printEmployee(temp->emp);
        }
        else{
            cout << "Employee not found "<< endl;
        }

       }
            else if(choice ==4){
        char name[20];
        cout << "Enter Name to search : ";
        cin >> name ;
        Node* temp = list.searchNodeByName(name);
        if(temp!=NULL){
            printEmployee(temp->emp);
        }
        else{
            cout << "Employee not found "<< endl;
        }

       }
       else if(choice ==5){
        list.printList();
       }
       else if(choice ==6){
        list.freeList();
       }
       else if(choice==7){
        int loc;
        cout<<"Enter location to delete : ";
        cin>> loc ;
        int deleted = list.deleteNode(loc);
        if(deleted){
            cout<<"Node deleted successfully "<<endl;
        }
        else{
            cout<<"Node deletion failed "<<endl;
        }
       }
     



    }while(choice!=8);
}
