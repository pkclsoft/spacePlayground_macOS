//  Created by Peter Easdown on 4/3/18.
//  Copyright © 2018 PKCLsoft. All rights reserved.
//

import Foundation
import CoreGraphics
import SceneKit

public extension CGPoint {

    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint.init(x: left.x - right.x, y: left.y - right.y)
    }

    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint.init(x: left.x + right.x, y: left.y + right.y)
    }

    static func * (v: CGPoint, s: CGFloat) -> CGPoint {
        return CGPoint.init(x: v.x*s, y: v.y*s)
    }

    static func lerp(a: CGPoint, b: CGPoint, alpha:CGFloat) -> CGPoint {
        return (a * (1.0 - alpha)) + (b * alpha)
    }

    static func dot (left: CGPoint, right: CGPoint) -> CGFloat {
        return left.x*right.x + left.y*right.y;

    }

    func distanceTo(other: CGPoint) -> CGFloat {
        return  (self - other).lengthSQ().squareRoot()
    }

    func lengthSQ() -> CGFloat {
        return CGPoint.dot(left: self, right: self)
    }

}

public extension CGFloat {

    static func lerp(a: CGFloat, b: CGFloat, x: CGFloat) -> CGFloat {
        return (a * (1.0 - x) + b * x)
    }
}

public extension SCNVector3 {

    func lerp(other: SCNVector3, t: CGFloat) -> SCNVector3 {
        let selfAsGLK = SCNVector3ToGLKVector3(self)
        let otherAsGLK = SCNVector3ToGLKVector3(other)

        return SCNVector3FromGLKVector3(GLKVector3Lerp(selfAsGLK, otherAsGLK, Float(t)))
    }

    static func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3.init(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
    }

    func length() -> CGFloat {
        let xSq = x * x
        let ySq = y * y
        let zSq = z * z
        let sum = xSq + ySq + zSq
        return (CGFloat)(sum.squareRoot())
    }

    static func - (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(l.x - r.x, l.y - r.y, l.z - r.z)
    }

    func distanceTo(other: SCNVector3) -> CGFloat {
        let node1Pos = SCNVector3ToGLKVector3(self)
        let node2Pos = SCNVector3ToGLKVector3(other)

        return (CGFloat)(GLKVector3Distance(node1Pos, node2Pos))
    }

    /**
     * Calculates the dot product between two SCNVector3.
     */
    func dot(_ vector: SCNVector3) -> Float {
        let xS = x * vector.x
        let yS = y * vector.y
        let zS = z * vector.z

        return Float(xS + yS + zS)
    }

    /**
     * Calculates the cross product between two SCNVector3.
     */
    func cross(_ vector: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(y * vector.z - z * vector.y, z * vector.x - x * vector.z, x * vector.y - y * vector.x)
    }

    /**
     * Normalizes the vector described by the SCNVector3 to length 1.0 and returns
     * the result as a new SCNVector3.
     */
    func normalized() -> SCNVector3 {
        return self / length()
    }

    /**
     * Normalizes the vector described by the SCNVector3 to length 1.0.
     */
    mutating func normalize() -> SCNVector3 {
        self = normalized()
        return self
    }

    /**
     * Multiplies the x, y and z fields of a SCNVector3 with the same scalar value and
     * returns the result as a new SCNVector3.
     */
    static func * (vector: SCNVector3, scalar: CGFloat) -> SCNVector3 {
        return SCNVector3Make(vector.x * scalar, vector.y * scalar, vector.z * scalar)
    }

    static func * (scalar: CGFloat, vector: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(vector.x * scalar, vector.y * scalar, vector.z * scalar)
    }

    /**
     * Divides two SCNVector3 vectors abd returns the result as a new SCNVector3
     */
    static func / (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x / right.x, left.y / right.y, left.z / right.z)
    }

    /**
     * Divides the x, y and z fields of a SCNVector3 by the same scalar value and
     * returns the result as a new SCNVector3.
     */
    static func / (vector: SCNVector3, scalar: CGFloat) -> SCNVector3 {
        return SCNVector3Make(vector.x / scalar, vector.y / scalar, vector.z / scalar)
    }

}

