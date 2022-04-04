//  Created by Peter Easdown on 4/3/18.
//  Copyright © 2018 PKCLsoft. All rights reserved.
//

import Foundation
import SceneKit

public class Satelite : SCNNode {

    override init() {
        super.init()
    }

    public init(atPosition : SCNVector3) {
        super.init()

        let shape = SCNPyramid.init(width: 01.0, height: 02.0, length: 01.0)

        let m0 = SCNMaterial()
        m0.diffuse.contents = NSColor.gray

        let m1 = SCNMaterial()
        m1.diffuse.contents = NSColor.blue

        let m2 = SCNMaterial()
        m2.diffuse.contents = NSColor.red

        let m3 = SCNMaterial()
        m3.diffuse.contents = NSColor.green

        let m4 = SCNMaterial()
        m4.diffuse.contents = NSColor.yellow

        shape.materials = [m1, m2, m3, m4, m0]

        self.geometry = shape

        self.position = atPosition

        self.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0.0, y: -CGFloat.pi * 2.0, z: 0.0, duration: 10.0)))
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
