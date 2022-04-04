//  Created by Peter Easdown on 4/3/18.
//  Copyright © 2018 PKCLsoft. All rights reserved.
//

import Foundation
import SceneKit

public class PlanetaryData {

    public static let DISTANCE_SCALING_FACTOR = 10000.0
    public static let SIZE_SCALING_FACTOR = 100.0

    public static let SUN_RADIUS_KM = (69550.80) // KM
    public static let MERCURY_RADIUS_KM = (2439.0) //KM
    public static let VENUS_RADIUS_KM = (6052.0) //KM
    public static let EARTH_RADIUS_KM = (6358.0) // km
    public static let MOON_RADIUS_KM = (1737.0) // km
    public static let MARS_RADIUS_KM = (3390.0) // km
    public static let JUPITER_RADIUS_KM = (69911.0) // km
    public static let SATURN_RADIUS_KM = (58232.0) // km
    public static let NEPTUNE_RADIUS_KM = (24622.0) // km
    public static let URANUS_RADIUS_KM = (25362.0) // km
    public static let PLUTO_RADIUS_KM = (1188.3) // km

    public static let MERCURY_RADIUS = (MERCURY_RADIUS_KM / SIZE_SCALING_FACTOR)
    public static let VENUS_RADIUS = (VENUS_RADIUS_KM / SIZE_SCALING_FACTOR)
    public static let EARTH_RADIUS = (EARTH_RADIUS_KM / SIZE_SCALING_FACTOR)
    public static let MOON_RADIUS = (MOON_RADIUS_KM / SIZE_SCALING_FACTOR)
    public static let MARS_RADIUS = (MARS_RADIUS_KM / SIZE_SCALING_FACTOR)
    public static let JUPITER_RADIUS = (JUPITER_RADIUS_KM / SIZE_SCALING_FACTOR)
    public static let SATURN_RADIUS = (SATURN_RADIUS_KM / SIZE_SCALING_FACTOR)
    public static let NEPTUNE_RADIUS = (NEPTUNE_RADIUS_KM / SIZE_SCALING_FACTOR)
    public static let URANUS_RADIUS = (URANUS_RADIUS_KM / SIZE_SCALING_FACTOR)
    public static let PLUTO_RADIUS = (PLUTO_RADIUS_KM / SIZE_SCALING_FACTOR)
    public static let SUN_RADIUS = (SUN_RADIUS_KM / SIZE_SCALING_FACTOR)

    public static let MERCURY_ORBIT_DISTANCE_KM =   (57910000.0) // km from sun
    public static let VENUS_ORBIT_DISTANCE_KM   =  (108200000.0) // km from sub
    public static let EARTH_ORBIT_DISTANCE_KM   =  (149600000.0) // km from sun
    public static let MOON_ORBIT_DISTANCE_KM    =     (384000.0) // km from earth
    public static let MARS_ORBIT_DISTANCE_KM    =  (227900000.0) // km from sun
    public static let JUPITER_ORBIT_DISTANCE_KM =  (778500000.0) // km from sun
    public static let SATURN_ORBIT_DISTANCE_KM  = (1433000000.0) // km from sun
    public static let NEPTUNE_ORBIT_DISTANCE_KM = (4495000000.0) // km from sun
    public static let URANUS_ORBIT_DISTANCE_KM  = (2871000000.0) // km from sun
    public static let PLUTO_ORBIT_DISTANCE_KM   = (5906376272.0) // km from sun

    public static let MERCURY_ORBIT_RADIUS  = (MERCURY_ORBIT_DISTANCE_KM / DISTANCE_SCALING_FACTOR)
    public static let VENUS_ORBIT_RADIUS  = (VENUS_ORBIT_DISTANCE_KM / DISTANCE_SCALING_FACTOR)
    public static let EARTH_ORBIT_RADIUS = (EARTH_ORBIT_DISTANCE_KM / DISTANCE_SCALING_FACTOR)
    public static let MOON_ORBIT_RADIUS  = (MOON_ORBIT_DISTANCE_KM / SIZE_SCALING_FACTOR)
    public static let MARS_ORBIT_RADIUS  = (MARS_ORBIT_DISTANCE_KM / DISTANCE_SCALING_FACTOR)
    public static let JUPITER_ORBIT_RADIUS  = (JUPITER_ORBIT_DISTANCE_KM / DISTANCE_SCALING_FACTOR)
    public static let SATURN_ORBIT_RADIUS  = (SATURN_ORBIT_DISTANCE_KM / DISTANCE_SCALING_FACTOR)
    public static let NEPTUNE_ORBIT_RADIUS  = (NEPTUNE_ORBIT_DISTANCE_KM / DISTANCE_SCALING_FACTOR)
    public static let URANUS_ORBIT_RADIUS  = (URANUS_ORBIT_DISTANCE_KM / DISTANCE_SCALING_FACTOR)
    public static let PLUTO_ORBIT_RADIUS = (PLUTO_ORBIT_DISTANCE_KM / DISTANCE_SCALING_FACTOR)

    public static let ONE_TIME_UNIT = (60.0)  // one minute
    public static let DAY_LENGTH = (24.0 * 60.0 * ONE_TIME_UNIT)

    public static let MERCURY_ORBIT_LENGTH = (88.0 * DAY_LENGTH)
    public static let MERCURY_DAY_LENGTH = (58.625 * DAY_LENGTH)
    public static let VENUS_ORBIT_LENGTH = (225.0 * DAY_LENGTH)
    public static let VENUS_DAY_LENGTH = (116.75 * DAY_LENGTH)
    public static let EARTH_ORBIT_LENGTH = (365.0 * DAY_LENGTH)
    public static let EARTH_DAY_LENGTH = (1.0/1.0 * DAY_LENGTH)
    public static let MOON_ORBIT_LENGTH = (27.0 * DAY_LENGTH)
    public static let MOON_DAY_LENGTH = (MOON_ORBIT_LENGTH)
    public static let MARS_ORBIT_LENGTH = (687.0 * DAY_LENGTH)
    public static let MARS_DAY_LENGTH = (1.02569444444 * DAY_LENGTH)
    public static let JUPITER_ORBIT_LENGTH = (4380.0 * DAY_LENGTH)
    public static let JUPITER_DAY_LENGTH = (0.416 * DAY_LENGTH)
    public static let SATURN_ORBIT_LENGTH = (10585.0 * DAY_LENGTH)
    public static let SATURN_DAY_LENGTH = (1.116 * DAY_LENGTH)
    public static let NEPTUNE_ORBIT_LENGTH = (60225.0 * DAY_LENGTH)
    public static let NEPTUNE_DAY_LENGTH = (0.66 * DAY_LENGTH)
    public static let URANUS_ORBIT_LENGTH = (30660 * DAY_LENGTH)
    public static let URANUS_DAY_LENGTH = (0.708 * DAY_LENGTH)
    public static let PLUTO_ORBIT_LENGTH = (90560 * DAY_LENGTH)
    public static let PLUTO_DAY_LENGTH = (6.4 * DAY_LENGTH)

    public enum Planetoids : Int {
        case Sun
        case Mercury
        case Venus
        case Earth
        case Mars
        case Jupiter
        case Saturn
        case Uranus
        case Neptune
        case Pluto
        case Moon
    }

    public struct OrbitalData {
        public var radius: Double = 0.0
        var axialTilt: Double = 0.0
        var orbitRadius: Double = 0.0
        var orbitDuration: TimeInterval = 0.0
        var dayDuration: TimeInterval = 0.0
        var hasRing : Bool = false

        public static func OrbitalDataMake(_ radius: Double, _ orbitRadius: Double, _ orbitDuration: TimeInterval, _ dayDuration: TimeInterval, _ axialTilt: Double, _ hasRing: Bool) -> OrbitalData {
            var result : OrbitalData = OrbitalData.init()

            result.radius = radius
            result.orbitRadius = orbitRadius
            result.orbitDuration = orbitDuration
            result.dayDuration = dayDuration
            result.hasRing = hasRing
            result.axialTilt = axialTilt

            return result
        }
    }

    static let orbitalData : [OrbitalData] = [
        OrbitalData.OrbitalDataMake(SUN_RADIUS, 0.0, 0.0, 0.0, 0.0, false),
        OrbitalData.OrbitalDataMake(MERCURY_RADIUS, MERCURY_ORBIT_RADIUS, MERCURY_ORBIT_LENGTH, MERCURY_DAY_LENGTH, 0.034, false),
        OrbitalData.OrbitalDataMake(VENUS_RADIUS, VENUS_ORBIT_RADIUS, VENUS_ORBIT_LENGTH, VENUS_DAY_LENGTH, 2.64, false),
        OrbitalData.OrbitalDataMake(EARTH_RADIUS, EARTH_ORBIT_RADIUS, EARTH_ORBIT_LENGTH, EARTH_DAY_LENGTH, 23.4392811, false),
        OrbitalData.OrbitalDataMake(MARS_RADIUS, MARS_ORBIT_RADIUS, MARS_ORBIT_LENGTH, MARS_DAY_LENGTH, 25.19, false),
        OrbitalData.OrbitalDataMake(JUPITER_RADIUS, JUPITER_ORBIT_RADIUS, JUPITER_ORBIT_LENGTH, JUPITER_DAY_LENGTH, 3.13, false),
        OrbitalData.OrbitalDataMake(SATURN_RADIUS, SATURN_ORBIT_RADIUS, SATURN_ORBIT_LENGTH, SATURN_DAY_LENGTH, 26.73, true),
        OrbitalData.OrbitalDataMake(URANUS_RADIUS, URANUS_ORBIT_RADIUS, URANUS_ORBIT_LENGTH, URANUS_DAY_LENGTH, 97.77, false),
        OrbitalData.OrbitalDataMake(NEPTUNE_RADIUS, NEPTUNE_ORBIT_RADIUS, NEPTUNE_ORBIT_LENGTH, NEPTUNE_DAY_LENGTH, 28.32, false),
        OrbitalData.OrbitalDataMake(PLUTO_RADIUS, PLUTO_ORBIT_RADIUS, PLUTO_ORBIT_LENGTH, PLUTO_DAY_LENGTH, 122.53, false),
        OrbitalData.OrbitalDataMake(MOON_RADIUS, MOON_ORBIT_RADIUS, MOON_ORBIT_LENGTH, MOON_DAY_LENGTH, 6.687, false)
    ]

    public static func orbitalDataFor(planetoid: Planetoids) -> OrbitalData {
        return orbitalData[planetoid.rawValue]
    }

    public struct KeplerData {
        var name: String = ""
        var a: Double = 0.0
        var e: Double = 0.0
        var I: Double = 0.0
        var L: Double = 0.0
        var w: Double = 0.0
        var node: Double = 0.0
        var aCy: Double = 0.0
        var eCy: Double = 0.0
        var ICy: Double = 0.0
        var LCy: Double = 0.0
        var wCy: Double = 0.0
        var nodeCy: Double = 0.0

        public static func KeplerDataMake(_ name: String, _ a: Double, _ e: Double, _ I: Double, _ L: Double, _ w: Double, _ node: Double, _ aCy: Double, _ eCy: Double, _ ICy: Double, _ LCy: Double, _ wCy: Double, _ nodeCy: Double) -> KeplerData {
            var result : KeplerData = KeplerData.init()

            result.name = name
            result.a = a
            result.e = e
            result.I = I
            result.L = L
            result.w = w
            result.node = node
            result.aCy = aCy
            result.eCy = eCy
            result.ICy = ICy
            result.LCy = LCy
            result.wCy = wCy
            result.nodeCy = nodeCy

            return result
        }
    }

    static let keplerData : [KeplerData] = [
        KeplerData.KeplerDataMake("Sun", 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),

        KeplerData.KeplerDataMake("Mercury", 0.38709927, 0.20563593, 7.00497902, 252.25032350, 77.45779628, 48.33076593, 0.00000037, 0.00001906, -0.00594749, 149472.67411175, 0.16047689, -0.12534081),

        KeplerData.KeplerDataMake("Venus", 0.72333566, 0.00677672, 3.39467605, 181.97909950, 131.60246718, 76.67984255, 0.00000390, -0.00004107, -0.00078890, 58517.81538729, 0.00268329, -0.27769418),

        KeplerData.KeplerDataMake("Earth", 1.00000261, 0.01671123, -0.00001531, 100.46457166, 102.93768193, 0.0, 0.00000562, -0.00004392, -0.01294668, 35999.37244981, 0.32327364, 0.0),

        KeplerData.KeplerDataMake("Mars", 1.52371034, 0.09339410, 1.84969142, -4.55343205, -23.94362959, 49.55953891, 0.00001847, 0.00007882, -0.00813131, 19140.30268499, 0.44441088, -0.29257343),

        KeplerData.KeplerDataMake("Jupiter", 5.20288700, 0.04838624, 1.30439695, 34.39644051, 14.72847983, 100.47390909, -0.00011607, -0.00013253, -0.00183714, 3034.74612775, 0.21252668, 0.20469106),

        KeplerData.KeplerDataMake("Saturn", 9.53667594, 0.05386179, 2.48599187, 49.95424423, 92.59887831, 113.66242448, -0.00125060, -0.00050991, 0.00193609, 1222.49362201, -0.41897216, -0.28867794),

        KeplerData.KeplerDataMake("Uranus", 19.18916464, 0.04725744, 0.77263783, 313.23810451, 170.95427630, 74.01692503, -0.00196176, -0.00004397, -0.00242939, 428.48202785, 0.40805281, 0.04240589),

        KeplerData.KeplerDataMake("Neptune", 30.06992276, 0.00859048, 1.77004347, -55.12002969, 44.96476227, 131.78422574, 0.00026291, 0.00005105, 0.00035372, 218.45945325, -0.32241464, -0.00508664),

        KeplerData.KeplerDataMake("Pluto", 39.48211675, 0.24882730, 17.14001206, 238.92903833, 224.06891629, 110.30393684, -0.00031596, 0.00005170, 0.00004818, 145.20780515, -0.04062942, -0.01183482),

        // The moon doesn't behave in the same way, so this is just a placeholder.
        //
        KeplerData.KeplerDataMake("Moon", 0.0, 0.0, 5.145, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    ]

    public static func dataFor(planetoid: Planetoids) -> KeplerData {
        return keplerData[planetoid.rawValue]
    }

    public static func nameFor(planetoid: Planetoids) -> String {
        return keplerData[planetoid.rawValue].name
    }

    public static func positionFor(planetoid: Planetoids) -> SCNVector3 {
        return positionFor(planetoid: planetoid, onDate: Date.init())
    }

    public static func positionFor(planetoid: Planetoids, onDate: Date) -> SCNVector3 {
        let data = dataFor(planetoid: planetoid)

        return planetPosition(date: onDate, planet: data)
    }

    // MARK: maths

    static func sin(degrees: Double)->Double{
        return __sinpi(degrees/180)
    }
    static func cos(degrees: Double)->Double {
        return __cospi(degrees/180)
    }

    static func dateToJulian(date: Date)->Double{
        return 2440587.5 + date.timeIntervalSince1970/86400
    }

    static func ecliptic(data:KeplerData, xp: Double, yp: Double, zp: Double) -> SCNVector3 {
        let xecl =
            (cos(degrees:data.w) * cos(degrees:data.node) -
                sin(degrees:data.w) * sin(degrees:data.node) * cos(degrees:data.I)) * xp +
                (-sin(degrees:data.w) * cos(degrees:data.node) -
                    cos(degrees:data.w) * sin(degrees:data.node) * cos(degrees:data.I)) * yp

        let yecl =
            (cos(degrees: data.w) * sin(degrees: data.node) +
                sin(degrees: data.w) * cos(degrees: data.node) * cos(degrees: data.I)) * xp +
                (-sin(degrees: data.w) * sin(degrees: data.node) +
                    cos(degrees: data.w) * cos(degrees: data.node) * cos(degrees: data.I)) * yp

        let zecl =
            sin(degrees:data.w) * sin(degrees:data.I) * xp +
                cos(degrees:data.w) * sin(degrees:data.I) * yp

        return SCNVector3Make(CGFloat(xecl), CGFloat(yecl), CGFloat(zecl))
    }

    static func planetPosition(date: Date, planet: KeplerData)-> SCNVector3 {
        let julian = dateToJulian(date: date)
        let T = (julian - 2451545)/36525
        let newA = (planet.a * EARTH_ORBIT_RADIUS) + (planet.aCy * T)
        let newE = planet.e + (planet.eCy * T)
        let newI = planet.I + (planet.ICy * T)
        let newL = planet.L + (planet.LCy * T)
        let newW = planet.w + (planet.wCy * T)
        let newNode = planet.node + (planet.nodeCy * T)
        let elements = KeplerData(name: "new", a: newA, e: newE, I: newI, L: newL, w: newW, node: newNode, aCy: 0, eCy: 0, ICy: 0, LCy: 0, wCy: 0, nodeCy: 0)

        var oldE = elements.L - (elements.w + elements.node)
        let M = oldE
        var E = M
        let e_star = elements.e * 180/Double.pi
        while abs(E - oldE) > 1/10000 * 180.0/Double.pi {
            oldE = E
            E = M + e_star * self.sin(degrees: oldE)
        }
        let xp = elements.a * (cos(degrees: E) - elements.e)
        let yp = elements.a * sqrt(1 - elements.e * elements.e) * sin(degrees: E)
        let zp:Double = 0

        return ecliptic(data: elements, xp: xp, yp: yp, zp: zp)
    }

}
