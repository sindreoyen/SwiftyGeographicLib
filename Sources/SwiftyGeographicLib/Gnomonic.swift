//
//  firecrestHORIZON.uk
//  
//  e-Mail  : kieran.conlon@firecresthorizon.uk
//  Twitter : @firecrestHRZN and @Kieran_Conlon
//

import CGeographicLib

public struct ForwardResult {
  public var x: Double = 0.0
  public var y: Double = 0.0
}

public struct ReverseResult {
  public var lat: Double = 0.0
  public var lon: Double = 0.0
}

public func forward(origin: (lat: Double, lon: Double), point: (lat: Double, lon: Double), ellipsoid: (a: Double, f: Double) = WGS84) -> ForwardResult {
  var fwd = ForwardResult()
  CGeographicLib.forward(origin.lat, origin.lon, point.lat, point.lon, &fwd.x, &fwd.y, ellipsoid.a, ellipsoid.f)
  return fwd
}

public func reverse(origin: (lat: Double, lon: Double), point: (x: Double, y: Double), ellipsoid: (a: Double, f: Double) = WGS84) -> ReverseResult {
  var rev = ReverseResult()
  CGeographicLib.reverse(origin.lat, origin.lon, point.x, point.y, &rev.lat, &rev.lon, ellipsoid.a, ellipsoid.f)
  return rev
}
