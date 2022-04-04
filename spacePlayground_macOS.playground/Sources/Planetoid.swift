//  Created by Peter Easdown on 4/3/18.
//  Copyright © 2018 PKCLsoft. All rights reserved.
//

import SceneKit

public struct GeographicPosition {
    public var latitude : CGFloat = 0.0
    public var longitude : CGFloat = 0.0

    public init(latitude: CGFloat, longitude: CGFloat) {
        self.longitude = longitude
        self.latitude = latitude
    }
}

public class Planetoid : SCNNode {

    public var orbitalData : PlanetaryData.OrbitalData = .init()
    public var isAMoon : Bool = false
    public var identifier : PlanetaryData.Planetoids = .Earth
    public var container : SCNNode = SCNNode()
    public var axisContainer : SCNNode = SCNNode()
    public var body : SCNNode? = nil
    var spotterSpinner : SCNNode = SCNNode()
    var spotter : SCNNode = SCNNode()

    override init() {
        super.init()
    }

    public init(identifier: PlanetaryData.Planetoids, color: NSColor, aMoon: Bool) {
        self.isAMoon = aMoon
        self.identifier = identifier
        self.orbitalData = PlanetaryData.orbitalDataFor(planetoid: self.identifier)

        super.init()

        self.name = PlanetaryData.nameFor(planetoid: identifier).lowercased()

        let shape = SCNSphere(radius: CGFloat(self.orbitalData.radius))

        let filename = String.init(format: "2k_%@", self.name!)
        let path = Bundle.main.path(forResource: filename, ofType: "jpg")

        if path != nil {
            let planetoidTexture = NSImage(contentsOfFile: path!)

            if planetoidTexture != nil {
                shape.firstMaterial?.diffuse.contents = planetoidTexture!
            } else {
                shape.firstMaterial?.diffuse.contents = color.withAlphaComponent(0.4)
            }
        } else {
            shape.firstMaterial?.diffuse.contents = color.withAlphaComponent(0.4)
        }

        self.addChildNode(self.container)

        self.body = SCNNode(geometry: shape)

        let tiltRadians = CGFloat(GLKMathDegreesToRadians(Float(self.orbitalData.axialTilt)))

        if self.identifier != .Sun {
            self.container.position = 
                PlanetaryData.positionFor(planetoid: self.identifier)

            self.container.addChildNode(axisContainer)

            let secondsToday = Date().timeIntervalSince1970.remainder(dividingBy: PlanetaryData.DAY_LENGTH)
            let timeFactor = CGFloat(secondsToday / PlanetaryData.DAY_LENGTH)

            self.axisContainer.eulerAngles = SCNVector3Make(CGFloat.pi/2.0 + tiltRadians, 0.0, (CGFloat.pi * 2.0 * timeFactor))

            self.axisContainer.addChildNode(self.body!)
            self.body!.addChildNode(self.spotterSpinner)

            self.spotter.position = SCNVector3Make(0.0, 0.0, CGFloat(self.orbitalData.radius))
            self.spotterSpinner.addChildNode(self.spotter)
        } else {
            self.container.addChildNode(body!)
        }

        print("\(self.name!) pos: \(self.container.position)")

        if self.orbitalData.hasRing {
            self.addRing()
        }

        if self.identifier != .Sun {
            self.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0.0, y: CGFloat.pi * 2.0, z: 0.0, duration: self.orbitalData.orbitDuration)))

            self.body!.runAction(
                SCNAction.repeatForever(SCNAction.rotateBy(x: 0.0, y: CGFloat.pi * 2.0, z:0.0, 
                                                         duration: self.orbitalData.dayDuration)))

            self.addOrbitRing(withColor: color)
        }
    }

    public convenience init(identifier: PlanetaryData.Planetoids, color: NSColor) {
        self.init(identifier: identifier, color: color, aMoon: false);
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func lookAtNode() -> SCNNode {
        if (self.isAMoon) {
            return self.body!
        } else {
            return self.container
        }
    }

    func addRing() {
        let filename = String.init(format: "2k_%@_ring", self.name!)
        let path = Bundle.main.path(forResource: filename, ofType: "png")

        if path != nil {
            let ring = SCNTube(innerRadius: CGFloat(self.orbitalData.radius + 60.0), outerRadius: CGFloat(self.orbitalData.radius + 200.0), height: 5.0)
            ring.firstMaterial?.diffuse.contents = NSImage(contentsOfFile: path!)

            let ringNode = SCNNode(geometry: ring)

            self.body!.addChildNode(ringNode)
        }
    }

    public func addOrbitRing(withColor: NSColor) {
        if self.isAMoon {
            let distance = CGFloat(self.body!.position.distanceTo(other: SCNVector3Zero))

            let orbitRing = SCNTube(innerRadius: distance, outerRadius: distance+2.0, height: 2.0)
            orbitRing.firstMaterial?.diffuse.contents = withColor

            let ringNode = SCNNode(geometry: orbitRing)

            self.addChildNode(ringNode)
        } else {
            let orbitalPeriod = self.orbitalData.orbitDuration
            var increments = TimeInterval(360)
            let incrementPeriod = orbitalPeriod / increments
            var date = Date()

            while increments >= 0 {
                let dotPosition = PlanetaryData.positionFor(planetoid: self.identifier, onDate: date)

                let dotShape = SCNSphere(radius: 15.0)  // extra fat just to make it more visible in this demo.
                dotShape.firstMaterial?.diffuse.contents = withColor
                let dot = SCNNode.init(geometry: dotShape)
                dot.position = dotPosition

                self.addChildNode(dot)

                date += incrementPeriod
                increments -= 1
            }
        }
    }

    func normalizedLongitude(input: Float) -> Float {
        var result = input

        if (result < 0.0) {
            result += (Float.pi * 2.0)
        }

        return result;
    }

    public func worldPositionAbove(geographicPosition: GeographicPosition) -> SCNVector3 {
        let phi = CGFloat(GLKMathDegreesToRadians(Float(-geographicPosition.latitude)))
        let theta = CGFloat(normalizedLongitude(input: GLKMathDegreesToRadians(Float(geographicPosition.longitude))))

        let x : CGFloat = phi
        let y : CGFloat = theta
        let z : CGFloat = 0.0

        self.spotterSpinner.eulerAngles = SCNVector3Make(x, y, z)

        let result = self.spotter.worldPosition

        return result
    }

    public func latLongFor(point: SCNVector3) -> GeographicPosition {
        let phi = acos(CGFloat(point.y) / CGFloat(self.orbitalData.radius)) //lat

        let theta = (atan2(CGFloat(point.x), CGFloat(point.z)) + CGFloat.pi + CGFloat.pi / 2.0).remainder(dividingBy: CGFloat.pi * 2.0) - CGFloat.pi //lon

        let result = GeographicPosition.init(latitude:
            180.0 * phi / CGFloat.pi - 90.0,
            longitude:
            180.0 * theta / CGFloat.pi)

        return result
    }

}
