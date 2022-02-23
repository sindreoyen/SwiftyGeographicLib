//
//  firecrestHORIZON.uk
//
//  e-Mail  : kieran.conlon@firecresthorizon.uk
//  Twitter : @firecrestHRZN and @Kieran_Conlon
//

import XCTest
@testable import SwiftyGeographicLib

final class SwiftyGeographicLibTests: XCTestCase {
    func testGeodesicInverse() throws {
      let p1 = (lat: 40.6, lon: -73.8)  // JFK Airport
      let p2 = (lat: 51.6, lon: -0.5)   // LHR Airport
      let inv = SwiftyGeographicLib.inverse(p1: p1, p2: p2)
      
      XCTAssertEqual(inv.s12,  5551759.400318679, accuracy: 1e-9)
      XCTAssertEqual(inv.az1, 51.19888284557982, accuracy: 1e-9)
      XCTAssertEqual(inv.az2,  107.82177673551425, accuracy: 1e-9)
    }
  
  func testGeodesicDirect() throws {
    let p1 = (lat: 40.6, lon: -73.8)  // JFK Airport
    let az1 = 51.19888284557982
    let s12 = 5551759.400318679
    let dir = SwiftyGeographicLib.direct(p1: p1, az1: az1, s12: s12)

    XCTAssertEqual(dir.lat2, 51.6, accuracy: 1e-9)
    XCTAssertEqual(dir.lon2, -0.5, accuracy: 1e-9)
    XCTAssertEqual(dir.az2, 107.82177673551425, accuracy: 1e-9)
  }
}
