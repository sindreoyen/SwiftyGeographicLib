//
//  firecrestHORIZON.uk
//
//  e-Mail  : kieran.conlon@firecresthorizon.uk
//  Twitter : @firecrestHRZN and @Kieran_Conlon
//

import CGeographicLib

public struct InverseResult {
  public var s12: Double = 0.0
  public var az1: Double = 0.0
  public var az2: Double = 0.0
}

public struct DirectResult {
  public var lat2: Double = 0.0
  public var lon2: Double = 0.0
  public var az2: Double = 0.0
}

public func inverse(p1: (lat: Double, lon: Double), p2: (lat: Double, lon: Double), ellipsoid: (a: Double, f: Double) = WGS84) -> InverseResult {
  var inv = InverseResult()
  CGeographicLib.inverse(p1.lat, p1.lon, p2.lat, p2.lon, &inv.s12, &inv.az1, &inv.az2, ellipsoid.a, ellipsoid.f)
  return inv
}

public func direct(p1: (lat: Double, lon: Double), az1: Double, s12: Double, ellipsoid: (a: Double, f: Double) = WGS84) -> DirectResult {
  var dir = DirectResult()
  CGeographicLib.direct(p1.lat, p1.lon, az1, s12, &dir.lat2, &dir.lon2, &dir.az2, ellipsoid.a, ellipsoid.f)
  return dir
}
