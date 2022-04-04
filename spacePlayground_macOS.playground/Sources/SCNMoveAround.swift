//  Created by Peter Easdown on 4/3/18.
//  Copyright © 2018 PKCLsoft. All rights reserved.
//

import Foundation
import SceneKit

public extension SCNAction {

    /*
     FROM:

     https://groups.google.com/d/msg/comp.soft-sys.matlab/daP09eUnmOo/emqMIUl2a2oJ

     v1 = [x1-x0;y1-y0;z1-z0]; % Vector from center to 1st point
     r = norm(v1); % The radius
     v2 = [x2-x0;y2-y0;z2-z0]; % Vector from center to 2nd point
     v3 = cross(cross(v1,v2),v1); % v3 lies in plane of v1 & v2 and is orthog. to v1
     v3 = r*v3/norm(v3); % Make v3 of length r
     % Let t range through the inner angle between v1 and v2
     t = linspace(0,atan2(norm(cross(v1,v2)),dot(v1,v2)));
     v = v1*cos(t)+v3*sin(t); % v traces great circle path, relative to center
     plot3(v(1,:)+x0,v(2,:)+y0,v(3,:)+z0) % Plot it in 3D

     */

    private class func v3ForPlaneOf(_ p1: SCNVector3, _ p2: SCNVector3) -> SCNVector3 {
        var v3 = p1.cross(p2).cross(p1)
        let r = p1.distanceTo(other: SCNVector3Zero)

        v3 = r * v3 / v3.length()

        return v3
    }

    private class func angleBetweenPoints(_ p1: SCNVector3, _ p2: SCNVector3) -> CGFloat {
        return CGFloat(atan2(Float(p1.cross(p2).length()), p1.dot(p2)))
    }

    class func moveAround(planetoid: Planetoid, fromPoint: SCNVector3, toPoint: SCNVector3, withDuration: TimeInterval) -> SCNAction {
        let startPosition = planetoid.parent!.convertPosition(fromPoint, to: planetoid.body!)
        let endPosition = planetoid.parent!.convertPosition(toPoint, to: planetoid.body!)

        let a = angleBetweenPoints(startPosition, endPosition)

        return SCNAction.customAction(duration: withDuration, action: { (node, timeElapsed) in
            let timeFactor = timeElapsed / CGFloat(withDuration)

           let t = CGFloat(a) * timeFactor

            let newPosition = startPosition * cos(t) + v3ForPlaneOf(startPosition, endPosition) * sin(t)
    
            node.position = planetoid.body!.convertPosition(newPosition, to: planetoid.parent!)
        })
    }

    class func moveAround(planetoid: Planetoid, toPoint: SCNVector3, withDuration: TimeInterval) -> SCNAction {
        let endPosition = planetoid.parent!.convertPosition(toPoint, to: planetoid.body!)
        var startPosition = SCNVector3Zero
        var angleBetweenPoints : CGFloat = 0.0

        return SCNAction.sequence([
            SCNAction.run({ (node)  in
                // This needs to be done inside the block so that we have access to the position of the
                // node when the block is actually executed.
                //
                startPosition = planetoid.parent!.convertPosition(node.position, to: planetoid.body!)

                angleBetweenPoints = SCNAction.angleBetweenPoints(startPosition, endPosition)
            }),
            SCNAction.customAction(duration: withDuration, action: { (node, timeElapsed) in
                let timeFactor = timeElapsed / CGFloat(withDuration)

                let t = angleBetweenPoints * timeFactor

                let newPosition = startPosition * cos(t) + v3ForPlaneOf(startPosition, endPosition) * sin(t)

                node.position = planetoid.body!.convertPosition(newPosition, to: planetoid.parent!)
            })])
    }

}
