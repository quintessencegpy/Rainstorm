//
//  DayViewModelTests.swift
//  RainstormTests/Users/lifeIsFloat/Desktop
//
//  Created by Pengyu Gou on 7/17/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Quick
import Nimble

@testable import Rainstorm

class DayViewModelTests: QuickSpec {

    override func spec() {
        describe("a DayViewModelTests") {
            var sut: DayViewModel!
            
            beforeEach {
                sut = self.dayViewModel
            }
            
            afterEach {
                sut = nil
            }
            
            describe("its date") {
                context("when got weather data") {
                    it("is Tue, August 28 2018") {
                        expect(sut.date).to(equal("Tue, August 28 2018"))
                    }
                }
            }
            
            describe("its time") {
                context("when got weather data") {
                    it("it is 09:02 PM") {
                        expect(sut.time).to(equal("09:02 PM"))
                    }
                }
            }
            
            describe("its summary") {
                context("when got weather data") {
                    it("is Overcast") {
                        expect(sut.summary).to(equal("Overcast"))
                    }
                }
            }
            
            describe("its temperature") {
                context("when got weather data") {
                    it("is 14.3 °C") {
                        expect(sut.temperature).to(equal("14.3 °C"))
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
    
    private var dayViewModel: DayViewModel {
        // Load Stub
        let data = loadStub(name: "darksky", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Dark Sky Response
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        
        return DayViewModel(weatherData: darkSkyResponse.current)
    }

}
