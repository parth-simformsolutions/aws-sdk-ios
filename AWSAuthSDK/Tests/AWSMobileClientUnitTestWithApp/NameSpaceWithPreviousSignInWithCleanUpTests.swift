//
//  NameSpaceWithPreviousSignInWithCleanUpTests.swift
//  AWSMobileClientUnitTestWithApp

import Foundation
import XCTest

@testable import AWSMobileClient
@testable import AWSCore

class NameSpaceWithPreviousSignInWithCleanUpTests: NameSpaceBaseTests {
    let userPoolID = "userPoolID"
    let appClientID = "appClientID"
    let identityPoolID = "identityPoolID"
    
    override func setUp() {
        super.setUp()
        do {
            try mockUserPoolSignedInUser()
        } catch {
            XCTFail("Error in mocking user pool signIn")
        }
        mockPreviousInstall(userPoolID: userPoolID, appClientID: appClientID, identityPoolID: identityPoolID)
    }
    
    /// Test user state remains the same on relaunching AWSMobilClient
    ///
    /// - Given: AWSMobileClient with previous information on keychain. Also mock the previous install with same configuration.
    /// - When:
    ///    - I invoke `initialize` on AWSMobileClient
    /// - Then:
    ///    - I should get back the user state as signedIn
    func testRelaunchWithSameConfigAfterCleanupAdded() throws {
       let configuration = createConfiguration(userPoolID: userPoolID,
                                                appClientID: appClientID,
                                                identityPoolID: identityPoolID)
        checkInitializeAndUserPoolSignIn(configuration)
    }
    
    /// Test user state being cleared when launching with a different configuration
    ///
    /// - Given: AWSMobileClient with previous information on keychain
    /// - When:
    ///    - I invoke `initialize` on AWSMobileClient with different configuration
    /// - Then:
    ///    - I should get back the user state as signedOut
    func testRelaunchWithDifferentUserPoolID() throws {
        let configuration = createConfiguration(userPoolID: "userPoolID2",
                                                appClientID: appClientID,
                                                identityPoolID: identityPoolID)
        checkInitializeAndSignedOut(configuration)
    }
    
    /// Test user state being cleared when launching with a different configuration
    ///
    /// - Given: AWSMobileClient with previous information on keychain
    /// - When:
    ///    - I invoke `initialize` on AWSMobileClient with different configuration
    /// - Then:
    ///    - I should get back the user state as signedOut
    func testRelaunchWithDifferentAppClientID() throws {

        let configuration = createConfiguration(userPoolID: userPoolID,
                                                appClientID: "appClientID2",
                                                identityPoolID: identityPoolID)
        checkInitializeAndSignedOut(configuration)
    }
    
    /// Test user state being cleared when launching with a different configuration
    ///
    /// - Given: AWSMobileClient with previous information on keychain
    /// - When:
    ///    - I invoke `initialize` on AWSMobileClient with different configuration
    /// - Then:
    ///    - I should get back the user state as signedOut
    func testRelaunchWithDifferentIdentityPoolID() throws {

        let configuration = createConfiguration(userPoolID: userPoolID,
                                                appClientID: appClientID,
                                                identityPoolID: "identityPoolID2")
        checkInitializeAndSignedOut(configuration)
    }
    
}

