//  File: Project27_MouseCoreGraphicsSandboxUITestsLaunchTests.swift
//  Project: Project27-MouseCoreGraphicsSandboxUITests
//  Created by: Noah Pope on 3/24/25.

import XCTest

final class Project27_MouseCoreGraphicsSandboxUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
