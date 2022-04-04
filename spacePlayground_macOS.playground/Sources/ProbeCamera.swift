//  Created by Peter Easdown on 4/3/18.
//  Copyright © 2018 PKCLsoft. All rights reserved.
//

import Foundation

import SceneKit

public class ProbeCamera : SCNNode {

    var lookAtConstraint : SCNLookAtConstraint? = nil
    var distanceConstraint : SCNDistanceConstraint? = nil

    var startPosition : SCNVector3 = SCNVector3Zero
    var targetPosition : SCNVector3 = SCNVector3Zero

    public override init() {
        super.init()
    }

    public init(atPosition: SCNVector3) {
        super.init()

        self.camera = SCNCamera()
        self.position = atPosition
        self.camera?.fieldOfView = 70.0
        self.camera?.zFar = 126000.0
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func flyTo(newPlanetoid: Planetoid, duration: TimeInterval) -> SCNAction {
        let radialDistance = CGFloat(newPlanetoid.orbitalData.radius * 2.0)

        let attachAction = SCNAction.run({ (node) in
            let selfAsCameraNode = node as! ProbeCamera

            if selfAsCameraNode.distanceConstraint == nil {
                selfAsCameraNode.distanceConstraint = SCNDistanceConstraint(target: newPlanetoid.body!)
            } else {
                selfAsCameraNode.distanceConstraint!.influenceFactor = 0.1
                selfAsCameraNode.distanceConstraint!.target = newPlanetoid.body!
            }

            selfAsCameraNode.distanceConstraint!.maximumDistance = radialDistance
            selfAsCameraNode.distanceConstraint!.minimumDistance = radialDistance
            selfAsCameraNode.constraints?.append(selfAsCameraNode.distanceConstraint!)
        })

        let lookAction = SCNAction.run({ (node) in
            let selfAsCameraNode = node as! ProbeCamera

            let newPosition = newPlanetoid.lookAtNode().worldPosition

            let distanceToNextPlanetoid = selfAsCameraNode.position.distanceTo(other: newPosition)
            let distanceBack = radialDistance / distanceToNextPlanetoid

            selfAsCameraNode.startPosition = selfAsCameraNode.position
            selfAsCameraNode.targetPosition = newPosition.lerp(other: selfAsCameraNode.position, t: distanceBack)

            if selfAsCameraNode.lookAtConstraint == nil {
                selfAsCameraNode.lookAtConstraint = SCNLookAtConstraint(target: newPlanetoid.lookAtNode())
            } else {
                selfAsCameraNode.lookAtConstraint!.influenceFactor = 0.1
                selfAsCameraNode.lookAtConstraint!.isIncremental = true
                selfAsCameraNode.lookAtConstraint!.target = newPlanetoid.lookAtNode()
            }

            selfAsCameraNode.constraints = [selfAsCameraNode.lookAtConstraint!]
        })


        let moveAction = SCNAction.customAction(duration: duration, action: { (node, timeElapsed) in
            let selfAsCameraNode = node as! ProbeCamera

            let timeFactor = TimeInterval(timeElapsed) / duration

            selfAsCameraNode.position = selfAsCameraNode.startPosition.lerp(other: selfAsCameraNode.targetPosition, t: CGFloat(timeFactor))
        })
        moveAction.timingMode = SCNActionTimingMode.easeInEaseOut

        return SCNAction.sequence([lookAction, moveAction, attachAction])

    }
}
