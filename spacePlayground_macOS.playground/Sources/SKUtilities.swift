//  Created by Peter Easdown on 4/3/18.
//  Copyright © 2018 PKCLsoft. All rights reserved.
//

import Foundation
import CoreGraphics
import SceneKit

public class SKUtilities {

    // MARK: Math functions

    /**
     * Converts an angle in the world where 0 is north in a clockwise direction to a world
     * where 0 is east in an anticlockwise direction.
     */
    static func angleFromDegrees(deg : Float) -> Float {
        return (450.0 - deg).truncatingRemainder(dividingBy: 360.0)
    }

    /*!
     *  Calculates the angle from one point to another, in radians.
     */
    static func angleFromPoint(from: CGPoint, toPoint: CGPoint) -> CGFloat {
        let pnormal : CGPoint = toPoint - from
        return atan2(pnormal.x, pnormal.y)
    }

    public static func pointOnCircleWithCentre(centerPt: CGPoint, andRadius: CGFloat, atDegrees: CGFloat) -> CGPoint {
        let DegreesToRadians = Float.pi / 180.0
        let radians = SKUtilities.angleFromDegrees(deg: Float(atDegrees)) * DegreesToRadians
        let xPos : CGFloat = CGFloat(andRadius + CGFloat(cos(radians)) * andRadius)
        let yPos : CGFloat = CGFloat(andRadius + CGFloat(sin(radians)) * andRadius)

        return centerPt + (CGPoint.init(x: xPos, y: yPos) - CGPoint.init(x: andRadius, y: andRadius))
    }

    static func geographicalPositionFor(vector3: SCNVector3, withRadius: CGFloat) -> CGPoint {
        let latitude : CGFloat = -(CGFloat(acos(vector3.y / CGFloat(withRadius))) - (CGFloat.pi/2.0)) //theta
        var longitude : CGFloat = CGFloat.pi - CGFloat(atan2(vector3.z, vector3.x)) //phi

        if (longitude > CGFloat.pi) {
            longitude = longitude - (2.0 * CGFloat.pi);
        }

        return CGPoint.init(x: longitude, y: latitude)
    }

    static func hashValueForGeographicalPosition(position: CGPoint) -> Int {
        let yHash = Int((round((position.y + (2*CGFloat.pi))*100.0)) * 1000000)
        let xHash = Int(round((position.x + (2*CGFloat.pi))*100.0))

        return yHash + xHash
    }

    static func isPointInPolygon(point: CGPoint, vertices : [CGPoint]) -> Bool {
        var inside = false
        var i : Int = 0
        var j : Int = vertices.count-1

        while i < vertices.count {

            if (((vertices[i].y > point.y) != (vertices[j].y > point.y)) &&
                (point.x < (vertices[j].x - vertices[i].x) *
                    (point.y - vertices[i].y) /
                    (vertices[j].y - vertices[i].y) +
                    vertices[i].x)) {
                inside = !inside
            }

            j = i
            i += 1
        }

        return inside
    }

}
