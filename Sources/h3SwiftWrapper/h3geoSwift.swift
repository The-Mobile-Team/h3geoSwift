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
    public init?(with index: UInt64) {
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
    
}

extension UInt64 {
    
    // Get the H3 cell's resolution
    public func getResolution() -> Int32 {
        return h3GetResolution(self)
    }
    
    // H3Index H3_EXPORT(h3ToParent)(H3Index h, int parentRes) {
    public func getParent(with resolution: Int32) -> UInt64 {
        return h3ToParent(self, resolution)
    }
    
    // Get the neighbor cells for index and ring size
    public func h3Neighbors(resolution: Int32, ringLevel: Int32) -> [H3Index] {
        
        let count = Int(maxKringSize(ringLevel))
        
        var neighbors = Array(repeating: H3Index(),
                              count: count)
        kRing(self, ringLevel, &neighbors);
        
        return neighbors
        
    }
    
    // Get all shape coordinates for a given set of 2D coordinates and ring size
    public func getCellPointsCoordinates(resolution: Int32, ringLevel: Int32) -> [CLLocationCoordinate2D] {

        var geoBoundary = GeoBoundary()
        
        h3ToGeoBoundary(self, &geoBoundary)
        var pointsCoords: [CLLocationCoordinate2D] = []
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.0.lat),
                                                   longitude: radsToDegs(geoBoundary.verts.0.lon)))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.1.lat),
                                                   longitude: radsToDegs(geoBoundary.verts.1.lon)))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.2.lat),
                                                   longitude: radsToDegs(geoBoundary.verts.2.lon)))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.3.lat),
                                                   longitude: radsToDegs(geoBoundary.verts.3.lon)))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.4.lat),
                                                   longitude: radsToDegs(geoBoundary.verts.4.lon)))
        pointsCoords.append(CLLocationCoordinate2D(latitude: radsToDegs(geoBoundary.verts.5.lat),
                                                   longitude: radsToDegs(geoBoundary.verts.5.lon)))
        
        return pointsCoords
        
    }
    
}
