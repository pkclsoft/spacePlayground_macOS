//  Created by Peter Easdown on 4/3/18.
//  Copyright © 2018 PKCLsoft. All rights reserved.
//


import SceneKit
import PlaygroundSupport

let sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 800, height: 600))

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true

var scene = SCNScene()
sceneView.scene = scene
sceneView.backgroundColor = NSColor.black
//sceneView.debugOptions = .showWireframe

// default lighting
sceneView.autoenablesDefaultLighting = false
sceneView.allowsCameraControl = false


// a camera
let cameraNode = ProbeCamera.init(atPosition: SCNVector3(x: 0.0, y: 0.0, z: 0.0))

scene.rootNode.addChildNode(cameraNode)

let mercury = Planetoid.init(identifier: .Mercury, color: NSColor.darkGray)

scene.rootNode.addChildNode(mercury)

let venus = Planetoid.init(identifier: .Venus, color: NSColor.yellow)

scene.rootNode.addChildNode(venus)

let earth = Planetoid(identifier: .Earth, color: NSColor.blue)

scene.rootNode.addChildNode(earth)

let moon = Moon.init(identifier: .Moon, orbiting: .Earth, color: NSColor.green, aMoon: true)

earth.container.addChildNode(moon)

let mars = Planetoid.init(identifier: .Mars, color: NSColor.brown)

scene.rootNode.addChildNode(mars)

let jupiter = Planetoid.init(identifier: .Jupiter, color: NSColor.lightGray)

scene.rootNode.addChildNode(jupiter)

let saturn = Planetoid.init(identifier: .Saturn, color: NSColor.yellow)

scene.rootNode.addChildNode(saturn)

let neptune = Planetoid.init(identifier: .Neptune, color: NSColor.blue)

scene.rootNode.addChildNode(neptune)

let uranus = Planetoid.init(identifier: .Uranus, color: NSColor.cyan)

scene.rootNode.addChildNode(uranus)

let sun = Planetoid.init(identifier: .Sun, color: NSColor.orange)

scene.rootNode.addChildNode(sun)

cameraNode.eulerAngles = SCNVector3Make(0.0, -CGFloat.pi, 0.0)

cameraNode.runAction(SCNAction.sequence([
    cameraNode.flyTo(newPlanetoid: earth, duration: 5.0),
    SCNAction.wait(duration:2.0),
    SCNAction.moveAround(planetoid: earth, toPoint: earth.worldPositionAbove(geographicPosition: GeographicPosition.init(latitude: -37.8136, longitude: 144.9631)), withDuration: 5.0),
    SCNAction.moveAround(planetoid: earth,  toPoint:earth.worldPositionAbove(geographicPosition: GeographicPosition.init(latitude: -6.1751, longitude: 106.8650)), withDuration: 5.0),
    SCNAction.wait(duration: 2.0),
    SCNAction.moveAround(planetoid: earth,  toPoint:earth.worldPositionAbove(geographicPosition: GeographicPosition.init(latitude: 49.2827, longitude: -123.1207)), withDuration: 5.0),
    SCNAction.wait(duration: 2.0),
    SCNAction.moveAround(planetoid: earth,  toPoint:earth.worldPositionAbove(geographicPosition: GeographicPosition.init(latitude: -37.8136, longitude: 144.9631)), withDuration: 5.0),

    SCNAction.wait(duration: 2.0),
    cameraNode.flyTo(newPlanetoid: venus, duration: 5.0),
    SCNAction.wait(duration: 2.0),
    cameraNode.flyTo(newPlanetoid: earth, duration: 5.0),
    SCNAction.wait(duration: 2.0),
    cameraNode.flyTo(newPlanetoid: mars, duration: 5.0),
    SCNAction.wait(duration: 2.0),
    cameraNode.flyTo(newPlanetoid: saturn, duration: 5.0),
    SCNAction.wait(duration: 2.0),
    cameraNode.flyTo(newPlanetoid: jupiter, duration: 5.0),
    SCNAction.wait(duration: 2.0),
    cameraNode.flyTo(newPlanetoid: earth, duration: 5.0),
    SCNAction.moveAround(planetoid: earth,  toPoint:earth.worldPositionAbove(geographicPosition: GeographicPosition.init(latitude: 49.2827, longitude: -123.1207)), withDuration: 5.0),
    SCNAction.wait(duration: 1.0),
    cameraNode.flyTo(newPlanetoid: moon, duration: 5.0)
    ]))
