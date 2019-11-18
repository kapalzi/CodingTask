//
//  Employee+CoreDataClass.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 18/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Employee)
public class Employee: NSManagedObject {

    static func createEmployee(id: Int16, firstName: String, lastName: String, age: Int16, gender: Int16, addresses: NSSet, context: NSManagedObjectContext) {
        
        let newEmployee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        newEmployee.id = id
        newEmployee.firstName = firstName
        newEmployee.lastName = lastName
        newEmployee.age = age
        newEmployee.gender = gender
        newEmployee.addresses = addresses
    }
    
    static func getEmployee(forId id: Int16, inContext context: NSManagedObjectContext) -> Employee? {
        
        let request = getEmployeesRequest(inContext: context)
        let predicate = NSPredicate(format: "id = %d", id)
        request.predicate = predicate
        
        return self.performFetch(fetchRequst: request, inContext: context).fetchedObjects?.first
    }
    
    static func getAllEmployees(inContext context: NSManagedObjectContext) -> [Employee]? {
        
        let request = getEmployeesRequest(inContext: context)
        
        return self.performFetch(fetchRequst: request, inContext: context).fetchedObjects
    }
    
    func update(firstName: String?, lastName: String?, age: Int16?, gender: Int16?, addresses: NSSet?) {
        
        self.firstName = firstName ?? self.firstName
        self.lastName = lastName ?? self.lastName
        self.age = age ?? self.age
        self.gender = gender ?? self.gender
        self.addresses = addresses ?? self.addresses
    }
    
    func remove(inContext context: NSManagedObjectContext) {
        
        context.delete(self)
    }
    
    private static func performFetch(fetchRequst: NSFetchRequest<Employee>, inContext context: NSManagedObjectContext) -> NSFetchedResultsController<Employee> {
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequst, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
               
        do {
           try fetchedResultController.performFetch()
        } catch {
           let fetchError = error as NSError
           print("Unresolved error %@, %@", fetchError, fetchError.userInfo)
        }
        
        return fetchedResultController
    }
    
    private static func getEmployeesRequest(inContext context: NSManagedObjectContext) -> NSFetchRequest<Employee> {
        
        let request: NSFetchRequest<Employee> = NSFetchRequest()
        let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
        request.entity = entity
        
        return request
    }
}
