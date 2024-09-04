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
        
        self.init(latitude: location.lat, longitude: location.lon)
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
