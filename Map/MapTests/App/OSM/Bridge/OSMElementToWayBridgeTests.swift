//
//  OSMElementToWayBridgeTests.swift
//  MapTests
//
//  Created by Benjamin Lewis on 26/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

// swiftlint:disable file_length
// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import Nimble
import Quick
import XCTest

@testable import Map

class OSMElementToWayBridgeTests: QuickSpec {
  override func spec() {
    context("given an OSMElementToWayBridge") {
      var geometry: () -> [OSMRawGeometry]? = { nil }
      var tags: () -> OSMRawTags? = { nil }
      var type: () -> String? = { nil }
      var osmRawElement: () -> OSMRawElement? = { nil }

      afterEach {
        geometry = { nil }
        tags = { nil }
        type = { nil }
        osmRawElement = { nil }
      }

      beforeEach {
        osmRawElement = {
          OSMRawElement(id: 1, geometry: geometry()!, tags: tags()!, type: type()!)
        }
      }

      describe(".make") {
        var subject: () -> OSMWay? = { nil }

        afterEach {
          subject = { nil }
        }

        beforeEach {
          subject = { OSMElementToWayBridge(osmRawElement: osmRawElement()!).make() }
        }

        context("when it is valid") {
          var bicycle: () -> String? = { nil }
          var bicycleRoad: () -> String? = { nil }
          var cycleStreet: () -> String? = { nil }
          var cycleway: () -> String? = { nil }
          var cyclewayBicycle: () -> String? = { nil }
          var cyclewayBoth: () -> String? = { nil }
          var cyclewayLeft: () -> String? = { nil }
          var cyclewayLeftSurface: () -> String? = { nil }
          var cyclewayLeftSurfaceColor: () -> String? = { nil }
          var cyclewayRight: () -> String? = { nil }
          var cyclewayRightSurface: () -> String? = { nil }
          var cyclewayRightSurfaceColor: () -> String? = { nil }
          var cyclewaySurface: () -> String? = { nil }
          var cyclewaySurfaceColor: () -> String? = { nil }
          var highway: () -> String? = { nil }
          var name: () -> String? = { nil }
          var rampBicycle: () -> String? = { nil }
          var smoothness: () -> String? = { nil }
          var surface: () -> String? = { nil }

          afterEach {
            bicycle = { nil }
            bicycleRoad = { nil }
            cycleStreet = { nil }
            cycleway = { nil }
            cyclewayBicycle = { nil }
            cyclewayBoth = { nil }
            cyclewayLeft = { nil }
            cyclewayLeftSurface = { nil }
            cyclewayLeftSurfaceColor = { nil }
            cyclewayRight = { nil }
            cyclewayRightSurface = { nil }
            cyclewayRightSurfaceColor = { nil }
            cyclewaySurface = { nil }
            cyclewaySurfaceColor = { nil }
            highway = { nil }
            name = { nil }
            rampBicycle = { nil }
            smoothness = { nil }
            surface = { nil }
          }

          beforeEach {
            type = { "way" }
            geometry = { [OSMRawGeometry(lat: 0, lon: 0)] }
            tags = {
              OSMRawTags(bicycle: bicycle(), bicycleRoad: bicycleRoad(), cycleStreet: cycleStreet(), cycleway: cycleway(), cyclewayBicycle: cyclewayBicycle(), cyclewayBoth: cyclewayBoth(), cyclewayLeft: cyclewayLeft(), cyclewayLeftSurface: cyclewayLeftSurface(), cyclewayLeftSurfaceColor: cyclewayLeftSurfaceColor(), cyclewayRight: cyclewayRight(), cyclewayRightSurface: cyclewayRightSurface(), cyclewayRightSurfaceColor: cyclewayRightSurfaceColor(), cyclewaySurface: cyclewaySurface(), cyclewaySurfaceColor: cyclewaySurfaceColor(), highway: highway(), name: name(), rampBicycle: rampBicycle(), smoothness: smoothness(), surface: surface())
            }
          }

          it("has the correct id") {
            expect(subject()?.id).to(equal(1))
          }

          describe("#bicycle") {
            var sut: () -> Bool? = { nil }

            afterEach {
              sut = { nil }
            }

            beforeEach {
              sut = { subject()!.bicycle }
            }

            it("is false") {
              expect(sut()).to(beFalsy())
            }

            context("when bicycle is yes") {
              beforeEach {
                bicycle = { "yes" }
              }

              it("is true") {
                expect(sut()).to(beTruthy())
              }
            }

            context("when bicycle is designated") {
              beforeEach {
                bicycle = { "designated" }
              }

              it("is true") {
                expect(sut()).to(beTruthy())
              }
            }

            context("when cyclewayBicycle is yes") {
              beforeEach {
                cyclewayBicycle = { "yes" }
              }

              it("is true") {
                expect(sut()).to(beTruthy())
              }
            }

            context("when cyclewayBicycle is designated") {
              beforeEach {
                cyclewayBicycle = { "designated" }
              }

              it("is true") {
                expect(sut()).to(beTruthy())
              }
            }
          }

          describe("#cycle") {
            var sut: () -> CyclewayType? = { nil }

            afterEach {
              sut = { nil }
            }

            beforeEach {
              sut = { subject()!.cycleway }
            }

            it("is unknown") {
              expect(sut()).to(equal(.unknown))
            }

            context("when bicycleRoad is yes") {
              beforeEach {
                bicycleRoad = { "yes" }
              }

              it("is a street") {
                expect(sut()).to(equal(.street))
              }
            }

            context("when cycleStreet is yes") {
              beforeEach {
                cycleStreet = { "yes" }
              }

              it("is a street") {
                expect(sut()).to(equal(.street))
              }
            }

            context("when cycleway is a lane") {
              beforeEach {
                cycleway = { "lane" }
              }

              it("is a lane") {
                expect(sut()).to(equal(.lane))
              }
            }

            context("when cyclewayLeft is a track") {
              beforeEach {
                cyclewayLeft = { "track" }
              }

              it("is a lane") {
                expect(sut()).to(equal(.track))
              }
            }

            context("when cyclewayRight is shared") {
              beforeEach {
                cyclewayRight = { "shared" }
              }

              it("is shared") {
                expect(sut()).to(equal(.shared))
              }
            }

            context("when cyclewayBoth is prohibited") {
              beforeEach {
                cyclewayBoth = { "prohibited" }
              }

              it("is a lane") {
                expect(sut()).to(equal(.prohibited))
              }
            }
          }

          describe("#highway") {
            var sut: () -> HighwayType? = { nil }

            afterEach {
              sut = { nil }
            }

            beforeEach {
              sut = { subject()!.highway }
            }

            it("is unknown") {
              expect(sut()).to(equal(.unknown))
            }

            context("when highway is a motorway") {
              beforeEach {
                highway = { "motorway" }
              }

              it("is a motorway") {
                expect(sut()).to(equal(.motorway))
              }
            }
          }

          describe("#smoothness") {
            var sut: () -> SmoothnessType? = { nil }

            afterEach {
              sut = { nil }
            }

            beforeEach {
              sut = { subject()!.smoothness }
            }

            it("is unknown") {
              expect(sut()).to(equal(.unknown))
            }

            context("when smoothness is excellent") {
              beforeEach {
                smoothness = { "excellent" }
              }

              it("is excellent") {
                expect(sut()).to(equal(.excellent))
              }
            }
          }

          describe("#surface") {
            var sut: () -> SurfaceType? = { nil }

            afterEach {
              sut = { nil }
            }

            beforeEach {
              sut = { subject()!.surface }
            }

            it("is unknown") {
              expect(sut()).to(equal(.unknown))
            }

            context("when surface is cobblestone") {
              beforeEach {
                surface = { "cobblestone" }
              }

              it("is excellent") {
                expect(sut()).to(equal(.cobblestone))
              }
            }
          }

          describe("#surfaceColor") {
            var sut: () -> Bool? = { nil }

            afterEach {
              sut = { nil }
            }

            beforeEach {
              sut = { subject()!.surfaceColor }
            }

            it("is false") {
              expect(sut()).to(equal(false))
            }

            context("when surface color is green") {
              beforeEach {
                cyclewaySurfaceColor = { "green" }
              }

              it("is true") {
                expect(sut()).to(beTruthy())
              }
            }

            context("when surface color is blue") {
              beforeEach {
                cyclewayLeftSurfaceColor = { "blue" }
              }

              it("is true") {
                expect(sut()).to(beTruthy())
              }
            }

            context("when surface color is yellow") {
              beforeEach {
                cyclewayRightSurfaceColor = { "yellow" }
              }

              it("is true") {
                expect(sut()).to(beTruthy())
              }
            }

            context("when surface color is red") {
              beforeEach {
                cyclewaySurfaceColor = { "red" }
              }

              it("is true") {
                expect(sut()).to(beTruthy())
              }
            }

            context("when surface color is some random color") {
              beforeEach {
                cyclewaySurfaceColor = { "rainbow" }
              }

              it("is true") {
                expect(sut()).to(beFalsy())
              }
            }
          }
        }

        context("when it is mostly valid") {
          beforeEach {
            geometry = { [OSMRawGeometry(lat: 0, lon: 0)] }
            tags = {
              OSMRawTags(bicycle: nil, bicycleRoad: nil, cycleStreet: nil, cycleway: nil, cyclewayBicycle: nil, cyclewayBoth: nil, cyclewayLeft: nil, cyclewayLeftSurface: nil, cyclewayLeftSurfaceColor: nil, cyclewayRight: nil, cyclewayRightSurface: nil, cyclewayRightSurfaceColor: nil, cyclewaySurface: nil, cyclewaySurfaceColor: nil, highway: nil, name: nil, rampBicycle: nil, smoothness: nil, surface: nil)
            }
            type = { "way" }
          }

          context("except for the type is a node") {
            beforeEach {
              type = { "node" }
            }

            it("returns nil") {
              expect(subject()).to(beNil())
            }
          }
        }
      }
    }
  }
}
