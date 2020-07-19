//
//  WeekDayViewModelTests.swift
//  RainstormTests
//
//  Created by Pengyu Gou on 7/19/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Quick
import Nimble

@testable import Rainstorm

class WeekDayViewModelTests: QuickSpec {
    
    override func spec() {
        describe("a WeekDayViewModel") {
            var sut: WeekDayViewModel!
            
            beforeEach {
                sut = self.weekDayViewModel
            }
           
            afterEach {
                sut = nil
            }
            
            describe("its day") {
                context("when got weather data") {
                    it("is Sunday") {
                        expect(sut.day).to(equal("Sunday"))
                    }
                }
            }
            
            describe("its date") {
                context("when got weather data") {
                    it("it is September 2") {
                        expect(sut.date).to(equal("September 2"))
                    }
                }
            }
            
            describe("its temperature") {
                context("when got weather data") {
                    it("is 12.2 °C - 20.1 °C") {
                        expect(sut.temperature).to(equal("12.2 °C - 20.1 °C"))
                    }
                }
            }
            
            describe("its windSpeed") {
                context("when got weather data") {
                    it("is 5 MPH") {
                        expect(sut.windSpeed).to(equal("5 MPH"))
                    }
                }
            }
            
            describe("its image") {
                context("when got weather data") {
                    it("is expected") {
                        let viewModelImage = sut.image!
                        let imageDataViewModel = viewModelImage.pngData()!
                        let imageDataReference = UIImage(named: "cloudy")!.pngData()!
                        
                        expect(viewModelImage).toNot(beNil())
                        expect(viewModelImage.size.width).to(equal(45.0))
                        expect(viewModelImage.size.height).to(equal(33.0))
                        expect(imageDataViewModel).to(equal(imageDataReference))
                    }
                }
            }
        }
    }

    private var weekDayViewModel: WeekDayViewModel {
        // Load Stub
        let data = loadStub(name: "darksky", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Dark Sky Response
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        
        return WeekDayViewModel(weatherData: darkSkyResponse.forecast[5])
    }

}
