//
//  firecrestHORIZON.uk
//
//  e-Mail  : kieran.conlon@firecresthorizon.uk
//  Twitter : @firecrestHRZN and @Kieran_Conlon
//

import XCTest
@testable import SwiftyGeographicLib

final class SwiftyGeographicLibGeodesicTests: XCTestCase {
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

final class SwiftyGeographicLibGnomonicTests: XCTestCase {
  func testGnomonicForward() throws {
    let origin = (lat: 48.0 + 50.0/60.0, lon: 2.0 + 20.0/60.0)  // Paris
    let point  = (lat: 50.9, lon: 1.8)  // Calais
    let fwd = SwiftyGeographicLib.forward(origin: origin, point: point)
    
    XCTAssertEqual(fwd.x, -37543.66988338346, accuracy: 1e-5)
    XCTAssertEqual(fwd.y, 230103.21385030495, accuracy: 1e-5)
  }

  func testGnomonicReverse() throws {
    let origin = (lat: 48.0 + 50.0/60.0, lon: 2.0 + 20.0/60.0)  // Paris
    let point  = (x: -38e3, y: 230e3)  // Calais
    let fwd = SwiftyGeographicLib.reverse(origin: origin, point: point)
    
    XCTAssertEqual(fwd.lat, 50.89904, accuracy: 1e-5)
    XCTAssertEqual(fwd.lon, 1.79353, accuracy: 1e-5)
  }
}
