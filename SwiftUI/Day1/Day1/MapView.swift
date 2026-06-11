//
//  MapView.swift
//  Day1
//
//  Created by Thaowpsta Saiid on 08/06/2026.
//

import MapKit
import SwiftUI

struct MapView: View {
    private var pos = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 31.2140,
                longitude: 29.8864
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    var body: some View {
        Map(initialPosition: pos)
    }
}

#Preview {
    MapView()
}
