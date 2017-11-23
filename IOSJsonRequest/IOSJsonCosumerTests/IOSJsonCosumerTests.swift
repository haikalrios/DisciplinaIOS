//
//  IOSJsonCosumerTests.swift
//  IOSJsonCosumerTests
//
//  Created by Haikal Rios on 16/11/2017.
//  Copyright © 2017 IESB. All rights reserved.
//

import XCTest
@testable import IOSJsonCosumer

class IOSJsonCosumerTests: XCTestCase {
    
    var subject : UserListTableViewController!
    
    override func setUp() {
        super.setUp()
        subject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserListTableViewController") as! UserListTableViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfRow(){
        XCTAssertEqual(subject.tableView.numberOfRows(inSection: 0), 10)
    }
    
 
    
}
