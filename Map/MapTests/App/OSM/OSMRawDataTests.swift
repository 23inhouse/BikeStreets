//
//  OSMRawDataTests.swift
//  MapTests
//
//  Created by Benjamin Lewis on 2/11/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

// swiftlint:disable function_body_length

import Nimble
import Quick
import XCTest

@testable import Map

class OSMRawDataTests: QuickSpec {
  override func spec() {
    context("given a some json data") {
      var json: () -> String? = { nil }
      var data: () -> Data? = { nil }

      afterEach {
        json = { nil }
        data = { nil }
      }

      beforeEach {
        data = { json()?.data(using: .utf8) }
      }

      describe(".decode") {
        var subject: () -> OSMRawData? = { nil }

        beforeEach {
          subject = {
            OSMRawData.decode(from: data()!)
          }
        }

        context("when the json is empty") {
          beforeEach {
            json = { "" }
          }

          it("has no elements") {
            expect(subject()?.elements).to(beNil())
          }
        }

        context("when the json is invalid") {
          beforeEach {
            json = { "foobar" }
          }

          it("has no elements") {
            expect(subject()?.elements).to(beNil())
          }
        }

        context("when the json has content") {
          beforeEach {
            json = { """
              {
                "elements": [
                  {
                    "geometry": [
                      {
                        "lat": 52.5131086,
                        "lon": 13.3264900
                      },
                      {
                        "lat": 52.5131073,
                        "lon": 13.3264688
                      }
                    ],
                    "id": 283919523,
                    "nodes": [
                      2468755017,
                      2468755011
                    ],
                    "tags": {
                      "bicycle": "yes",
                      "highway": "residential",
                      "oneway": "yes",
                      "surface": "asphalt"
                    },
                    "type": "way"
                  }
                ]
              }
              """
            }
          }

          it("has the correct number of elements") {
            expect(subject()?.elements.count).to(equal(1))
          }

          describe("the first element") {
            var sut: () -> OSMRawElement? = { nil }

            afterEach {
              sut = { nil }
            }

            beforeEach {
              sut = { subject()!.elements.first }
            }

            it("has the properties") {
              expect(sut()?.id).to(equal(283919523))
              expect(sut()?.type).to(equal("way"))
              expect(sut()?.geometry?.count).to(equal(2))
            }
          }

          describe("the first element's tags") {
            var sut: () -> OSMRawTags? = { nil }

            afterEach {
              sut = { nil }
            }

            beforeEach {
              sut = { subject()!.elements.first?.tags }
            }

            it("has the properties") {
              expect(sut()?.bicycle).to(equal("yes"))
              expect(sut()?.highway).to(equal("residential"))
              expect(sut()?.surface).to(equal("asphalt"))
              expect(sut()?.bicycleRoad).to(beNil())
              expect(sut()?.cycleStreet).to(beNil())
              expect(sut()?.cycleway).to(beNil())
              expect(sut()?.cyclewayBicycle).to(beNil())
              expect(sut()?.cyclewayBoth).to(beNil())
              expect(sut()?.cyclewayLeft).to(beNil())
              expect(sut()?.cyclewayLeftSurface).to(beNil())
              expect(sut()?.cyclewayLeftSurfaceColor).to(beNil())
              expect(sut()?.cyclewayRight).to(beNil())
              expect(sut()?.cyclewayRightSurface).to(beNil())
              expect(sut()?.cyclewayRightSurfaceColor).to(beNil())
              expect(sut()?.cyclewaySurface).to(beNil())
              expect(sut()?.cyclewaySurfaceColor).to(beNil())
              expect(sut()?.name).to(beNil())
              expect(sut()?.rampBicycle).to(beNil())
              expect(sut()?.smoothness).to(beNil())
            }
          }
        }
      }
    }
  }
}
