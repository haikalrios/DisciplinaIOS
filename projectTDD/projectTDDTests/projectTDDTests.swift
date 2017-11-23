//
//  projectTDDTests.swift
//  projectTDDTests
//
//  Created by Haikal Rios on 16/11/2017.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import XCTest
@testable import projectTDD

class projectTDDTests: XCTestCase {
    
    var subject : MovieTableViewController!
    
    override func setUp() {
        super.setUp()
        subject =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieTableViewController") as! MovieTableViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfRows(){
        XCTAssertEqual(subject?.tableView.numberOfRows(inSection: 0), 4)
    }
    
   
    
}
