//
//  WeekViewModelTests.swift
//  RainstormTests
//
//  Created by Pengyu Gou on 7/18/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Quick
import Nimble

@testable import Rainstorm

class WeekViewModelTests: QuickSpec {

    override func spec() {
        describe("a WeekViewModel") {
            var sut: WeekViewModel!
            
            beforeEach {
                sut = self.weekViewModel
            }
            
            afterEach {
                sut = nil
            }
            
            describe("its numberOfDays") {
                context("when got weather data") {
                    it("it 8") {
                        expect(sut.numberOfDays).to(equal(8))
                    }
                }
            }
            
            describe("its numberOfDays") {
                context("when got weather data") {
                    it("it 8") {
                        expect(sut.numberOfDays).to(equal(8))
                    }
                }
            }
            
            describe("its viewModel for index") {
                it("is expected") {
                    let weekDayViewModel = sut.viewModel(for: 5)
                    
                    expect(weekDayViewModel.day).to(equal("Sunday"))
                    expect(weekDayViewModel.date).to(equal("September 2"))
                }
            }
        }
    }
    
    private var weekViewModel: WeekViewModel {
        // Load Stub
        let data = loadStub(name: "darksky", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Dark Sky Response
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        
        return WeekViewModel(weatherData: darkSkyResponse.forecast)
    }

}
