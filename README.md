# SwiftyGeographicLib

[![Swift Version](https://img.shields.io/badge/swift-5.5-blue.svg)](https://swift.org)
![Platform](https://img.shields.io/badge/platform-macOS|linux--64-lightgray.svg)
[![GeographicLib Version](https://img.shields.io/badge/GeographicLib-2.1-blue.svg)](https://geographiclib.sourceforge.io/)

Swift wrapper for [Charles Karney's](https://sourceforge.net/u/karney/) C++ library for geodesics. See Karney's [GeographicLib](https://sourceforge.net/projects/geographiclib/) project.

## Description

### Current Implementation

#### Geodesic

- Geodesic.direct
- Geodesic.arcDirect
- Geodesic.inverse

The shortest path between two points (p1 & p2) on the ellipsoid having locations specified by p1 at (lat1, lon1) and p2 at (lat2, lon2) is called the geodesic.  Its length between p1 and p2 is s12 and the geodesic from p1 to p2 has forward azimuths az1 and az2 at the two end points.

Traditionally two geodesic problems are considered, **direct** and **inverse**.

##### The Direct Problem

Given `lat1`, `lon1`, `s12`, `az1`, determine `lat2`, `lon2`, and `az2`.  This is solved by the function `direct()`.

Example: Starting at New York JFK airport (lat=40.63972222, lon=-73.77888888), head on an initial bearing of 51.37288858° for a distance on 5,554,344m - compute the location of p2 and final forward azimuth on the WGS84 ellipsoid.

``` swift
import SwiftyGeographicLib
let dirResult = direct(p1: (lat: 40.63972222, lon: -73.77888888), az1: 51.37287886, s12: 5554344.26)
let p2Lat = dirResult.lat2         // 51.477500002 - lat of London Heathrow (LHR) airport
let p2Lon = dirResult.lon2         // -0.461388897 - lon of London Heathrow (LHR) airport
let p2FwdAzimuth = dirResult.az2   // 107.97130748 - forward bering at LHR
```

##### The ArcDirect variant

Similar the Direct problem, but instead of specifying the distance `s12` between the points, specify the central angle `a12` between the points.

``` swift
import SwiftyGeographicLib
let dirResult = arcDirect(p1: (lat: 40.6, lon: -73.8), az1: 51.19888284557982, a12: 49.94131021789904)
let p2Lat = dirResult.lat2         // 51.6 - lat of p2 (nr. London Heathrow (LHR) airport)
let p2Lon = dirResult.lon2         // -0.5 - lon of p2 (nr. London Heathrow (LHR) airport)
let p2FwdAzimuth = dirResult.az2   // 107.82177673551425 - forward bering at p2
```

##### The Inverse Problem

Given `lat1`, `lon1`, `lat2`, `lon2`, determine `s12`, `az1`, and `az2`.  This is solved by the function `inverse()`.

Example: Starting at New York JFK airport (lat=40.63972222, lon=-73.77888888) and ending at London Heathrow airport (lat=51.4775, lon=-0.46138888) - compute distance s12 and forward azimuths az1 and az2 on the WGS84 ellipsoid.

``` swift
import SwiftyGeographicLib
let invResult = inverse(p1: (lat: 40.63972222, lon: -73.77888888), p2: (lat: 51.4775, lon: -0.46138888))
let dist = invResult.s12          // 5554344.26   - dist between JFK to LHR
let p1FwdAzimuth = invResult.az1  // 51.37287886  - forward bearing at JFK
let p2FwdAzimuth = invResult.az2  // 107.97130749 - forward bering at LHR
```

#### Gnomonic

- Gnomonic.forward
- Gnomonic.reverse

##### Gnomonic Forward

Forward projection from geographic to gnomonic.

``` swift
import SwiftyGeographicLib
let origin = (lat: 48.0 + 50.0/60.0, lon: 2.0 + 20.0/60.0)  // Paris
let point  = (lat: 50.9, lon: 1.8)                          // Calais
let fwd = SwiftyGeographicLib.forward(origin: origin, point: point, ellipsoid: WGS84)
let x = fwd.x                 // x = -37543.66988338346
let y = fwd.y                 // y = 230103.21385030495

```

##### Gnomonic Reverse

Reverse projection from gnomonic to geographic.

``` swift
import SwiftyGeographicLib
let origin = (lat: 48.0 + 50.0/60.0, lon: 2.0 + 20.0/60.0)  // Paris
let point  = (x: -38e3, y: 230e3) 
let rev = SwiftyGeographicLib.reverse(origin: origin, point: point, ellipsoid: WGS84)
let lat = rev.lat                 // lat = 50.89904
let lon = rev.lon                 // lon = 1.79353

```

---

## Swift Package Management

``` swift
dependencies: [
        .package(url: "https://github.com/sindreoyen/SwiftyGeographicLib.git", branch: "main"),
    ],
```

## WGS as default ellipsoid and overriding WGS84

The package will use [WGS84](https://en.wikipedia.org/wiki/World_Geodetic_System#WGS84) as the default datum (semi-major axis, a = 6,378,137.0 m; flattening f = 1/298.257223563)
Other ellipsoids can be used by overrding the default ellipsoid a & f values.

Example for [ETRS89](https://en.wikipedia.org/wiki/European_Terrestrial_Reference_System_1989):

``` swift
let ETRS89 = (a: 6378137.0, f: 1 / 298.257222101)
let dirResult = direct(p1: (lat: 51.21, lon: 3.456), az1: 23.344, s12: 10000, ellipsoid: ETRS89)
```
