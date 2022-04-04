# spacePlayground_macOS
A relatively simple Swift Playground that was used in the very early stages of prototyping the solar system representation within World of Hex v2.0.

This code uses a set of Kepler Parameters to make a rough approximation of where each of the planets in the solar system are at a given time and date and time.

It creates instances of an SCNNode subclass to represent teach planetoid and position it.

A camera (ProbeCamera) is then added and instructed to fly from one planetoid to another.  These actions on the camera were originally intended to become an animation simulating the flight from one planetoid to another.

## Reference material
An algorithm for plotting the points between two positions on the surface of a sphere was borrowed from (thanks to Roger Stafford):
https://groups.google.com/d/msg/comp.soft-sys.matlab/daP09eUnmOo/emqMIUl2a2oJ

Source data for the Keplerian Elements was obtained from:
https://ssd.jpl.nasa.gov/planets/approx_pos.html

Textures were obtained from:
https://www.solarsystemscope.com/textures/