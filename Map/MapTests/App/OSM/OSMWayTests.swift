//
//  OSMWayTests.swift
//  MapTests
//
//  Created by Benjamin Lewis on 26/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import CoreLocation
import Nimble
import Quick
import XCTest

@testable import Map

class OSMWayTests: QuickSpec {
  override func spec() {
    context("given an OSMWay") {
      var subject: () -> OSMWay? = { nil }

      afterEach {
        subject = { nil }
      }

      beforeEach {
        subject = {
          OSMWay(id: 1, bicycle: nil, cycleway: nil, highway: nil, smoothness: nil, surface: nil, surfaceColor: nil)
        }
      }

      describe("#properties") {
        it("has default values") {
          expect(subject()!.id).to(equal(1))
          expect(subject()!.bicycle).to(beFalsy())
          expect(subject()!.cycleway).to(equal(.unknown))
          expect(subject()!.highway).to(equal(.unknown))
          expect(subject()!.smoothness).to(equal(.unknown))
          expect(subject()!.surface).to(equal(.unknown))
          expect(subject()!.surfaceColor).to(beFalsy())
        }
      }

      describe("#coordinates") {
        var sut: () -> [CLLocationCoordinate2D]? = { nil }

        context("when in the default state") {
          beforeEach {
            sut = { subject()!.coordinates }
          }

          it("has no coordinates") {
            expect(sut()!).to(beEmpty())
          }
        }

        context("when coordinates have been added") {
          beforeEach {
            sut = {
              let sut = subject()!
              sut.coordinates.append(CLLocationCoordinate2D(latitude: 0, longitude: 0))
              sut.coordinates.append(CLLocationCoordinate2D(latitude: 0, longitude: 0))
              return sut.coordinates
            }
          }

          it("has two coordinates") {
            expect(sut()!.count).to(equal(2))
          }
        }
      }
    }
  }
}
