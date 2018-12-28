//
//  UserTests.swift
//  AppTests
//
//  Created by Jean Raphael Bordet on 27/12/2018.
//

@testable import App

import Vapor
import XCTest
import FluentPostgreSQL

class UserTests: XCTestCase {
    let usersURI = "/api/users/"
    let usersName = "Alice"
    let usersUsername = "alicea"
    var app: Application!
    var conn: PostgreSQLConnection!
    
    override func setUp() {
        do {
            try Application.reset()
            app = try Application.testable()
            conn = try app.newConnection(to: .psql).wait()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    override func tearDown() {
        conn.close()
    }
    
    func testUsersCanBeRetrievedFromAPI() throws {
        let user = try User.create(name: usersName,
                                   username: usersUsername,
                                   on: conn)
        
        _ = try User.create(on: conn)
        
        let users = try app.getResponse(to: usersURI, decodeTo: [User].self)
        
        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users[0].name, user.name)
        XCTAssertEqual(users[0].username, user.username)
        XCTAssertEqual(users[0].id, user.id)
    }
    
    func testUserCanBeSavedWithAPI() throws {
        let user = User(name: usersName, username: usersUsername)
        
        let receivedUser = try app.getResponse(to: usersURI,
                                               method: .POST,
                                               headers: ["Content-Type": "application/json"],
                                               data: user,
                                               decodeTo: User.self)
        
        XCTAssertEqual(receivedUser.name, usersName)
        XCTAssertEqual(receivedUser.username, usersUsername)
        XCTAssertNotNil(receivedUser.id)
        
        let users = try app.getResponse(to: usersURI, decodeTo: [User].self)
        
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users[0].name, usersName)
        XCTAssertEqual(users[0].username, usersUsername)
        XCTAssertEqual(users[0].id, receivedUser.id)
    }
    
    func testGettingASingleUserFromTheAPI() throws {
        let user = try User.create(name: usersName, username: usersUsername, on: conn)
        
        let receivedUser = try app.getResponse(to: "\(usersURI)\(user.id!)", decodeTo: User.self)
        
        XCTAssertEqual(receivedUser.name, usersName)
        XCTAssertEqual(receivedUser.username, usersUsername)
        XCTAssertEqual(receivedUser.id, user.id)
    }
    
    static let allTests = [
        ("testUsersCanBeRetrievedFromAPI", testUsersCanBeRetrievedFromAPI),
        ("testUserCanBeSavedWithAPI", testUserCanBeSavedWithAPI),
        ("testGettingASingleUserFromTheAPI", testGettingASingleUserFromTheAPI)
        ]
}
