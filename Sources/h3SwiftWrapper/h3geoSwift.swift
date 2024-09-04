// h3.swift
//
// Created by Marc P on 09/03/2024
// Copyright © Marc P. All rights reserved.

import Foundation
import CoreLocation
import h3_C_Lib

extension CLLocationCoordinate2D {
    
    // Get the H3 cell index for a given set of 2D coordinates
    public func h3CellIndex(resolution: Int32) -> UInt64 {
        
        var location = GeoCoord(lat: degsToRads(latitude),
                                lon: degsToRads(longitude))
        let index = geoToH3(&location, resolution)
        
        return index
        
    }
    
    // init a 2d coordinate as the center of a H3 cell index
    public init?(with index: UInt64, resolution: Int32) {
        var location = GeoCoord()
        h3ToGeo(index, &location)
        
        self.init(latitude: radsToDegs(location.lat), longitude: radsToDegs(location.lon))
    }
    
    // Get the neighbor cells for a given set of 2D coordinates and ring size
    public func h3Neighbors(resolution: Int32, ringLevel: Int32) -> [H3Index] {
        
        let index = h3CellIndex(resolution: resolution)
        let count = Int(maxKringSize(ringLevel))
        
        var neighbors = Array(repeating: H3Index(),
                              count: count)
        kRing(index, ringLevel, &neighbors);
        
        return neighbors
        
    }
    
    // Get the neighbor cells for a given set of 2D coordinates and ring size
    public func get6PointsCoordinates(resolution: Int32, ringLevel: Int32) -> [CLLocationCoordinate2D] {

        let index = h3CellIndex(resolution: resolution)
        var geoBoundary = GeoBoundary()
        
        h3ToGeoBoundary(index, &geoBoundary)
        var pointsCoords: [CLLocationCoordinate2D] = []
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.0.lat),
                                                   longitude: geoBoundary.verts.0.lon))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.1.lat),
                                                   longitude: geoBoundary.verts.1.lon))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.2.lat),
                                                   longitude: geoBoundary.verts.2.lon))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.3.lat),
                                                   longitude: geoBoundary.verts.3.lon))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.4.lat),
                                                   longitude: geoBoundary.verts.4.lon))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.5.lat),
                                                   longitude: geoBoundary.verts.5.lon))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.6.lat),
                                                   longitude: geoBoundary.verts.6.lon))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.7.lat),
                                                   longitude: geoBoundary.verts.7.lon))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.8.lat),
                                                   longitude: geoBoundary.verts.8.lon))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.9.lat),
                                                   longitude: geoBoundary.verts.9.lon))
        
        return pointsCoords
        
    }
    
}
