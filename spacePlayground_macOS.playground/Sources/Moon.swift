//  Created by Peter Easdown on 4/3/18.
//  Copyright © 2018 PKCLsoft. All rights reserved.
//

import Foundation
import SceneKit
import GLKit

public class Moon : Planetoid {

    public var spinner : SCNNode = SCNNode()

    func normalize(v: Double) -> Double {
        var result = v - floor(v)

        if result < 0 {
            result += 1
        }

        return result
    }

    func dateToJulian(date: Date) -> Double {
        return 2440587.5 + date.timeIntervalSince1970/86400
    }

    func computePosition(forDate: Date) -> SCNVector3 {

        let JD = self.dateToJulian(date: forDate)

        // calculate moon's age in days
        var IP = normalize(v: ( JD - 2451550.1 ) / 29.530588853 )

        IP = IP * 2.0 * Double.pi                      // Convert phase to radians

        let deg = GLKMathRadiansToDegrees(Float(IP))

        let p = SKUtilities.pointOnCircleWithCentre(centerPt: CGPoint.init(x: 0.0, y: 0.0), andRadius: CGFloat(self.orbitalData.orbitRadius), atDegrees: CGFloat(deg))

        return SCNVector3Make(p.y, 0.0, p.x)
    }

    override init() {
        super.init()
    }

    public init(identifier: PlanetaryData.Planetoids, orbiting: PlanetaryData.Planetoids, color: NSColor, aMoon: Bool) {
        super.init()

        self.identifier = identifier
        self.isAMoon = aMoon
        self.orbitalData = PlanetaryData.orbitalDataFor(planetoid: self.identifier)
        self.name = PlanetaryData.nameFor(planetoid: self.identifier).lowercased()

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
            shape.firstMaterial?.diffuse.contents = color.withAlphaComponent(0.7)
        }

        self.body = SCNNode(geometry: shape)

        self.body?.position = self.computePosition(forDate: Date())
        self.body?.eulerAngles = SCNVector3Make(0.0, (CGFloat.pi/4.0)*3.0, (CGFloat.pi/4.0)*3.0)

        let tiltRadians = CGFloat(GLKMathDegreesToRadians(Float(PlanetaryData.dataFor(planetoid: self.identifier).I)))

        self.eulerAngles = SCNVector3Make(-CGFloat.pi/2.0, tiltRadians, 0.0)

        print("\(self.name!) : \(self.body!.position)")

        self.spinner.eulerAngles = SCNVector3Make(0.0, -CGFloat.pi/2.0, 0.0)

        self.spinner.addChildNode(body!)

        self.addChildNode(self.spinner)

        self.spinner.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0.0, y: -CGFloat.pi * 2.0, z: 0.0, duration: self.orbitalData.orbitDuration)))
        
        self.body!.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0.0, y: CGFloat.pi * 2.0, z: 0.0, duration: self.orbitalData.dayDuration)))

        self.addOrbitRing(withColor: color)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
