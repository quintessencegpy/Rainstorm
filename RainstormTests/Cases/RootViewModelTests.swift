//
//  RootViewModelTests.swift
//  RainstormTests
//
//  Created by Pengyu Gou on 7/19/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Quick
import Nimble

@testable import Rainstorm

class RootViewModelTests: QuickSpec {

    override func spec() {
        describe("a RootViewModel") {
            var sut: RootViewModel!
            var networkService: MockNetworkService!
            var locationService: MockLocationService!
            
            beforeEach {
                // Initialize Mock Network Service
                networkService = MockNetworkService()
                
                // Configure Mock Network Service
                networkService.data = self.loadStub(name: "darksky", extension: "json")
                
                // Initialize Mock Location Service
                locationService = MockLocationService()

                // Initialize Root View Model
                sut = RootViewModel(networkService: networkService, locationService: locationService)
            }
            
            afterEach {
                sut = nil
                networkService = nil
                locationService = nil
            }
            
            describe("refreshing") {
                
                afterEach {
                    UserDefaults.standard.removeObject(forKey: "didFetchWeatherData")
                }
                
                context("when get weatherData") {
                    it("get expected output") {
                        waitUntil { (done) in
                            sut.didFetchWeatherData = { (result) in
                                if case .success(let weatherData) = result {
                                    expect(weatherData.latitude).to(equal(37.8267))
                                    expect(weatherData.longitude).to(equal(-122.4233))
                                    done()
                                }
                            }
                            
                            sut.refresh()
                        }

                    }
                }
                
                context("when failed to fetch location") {
                    it("get notAuthorizedToRequestLocation error") {
                        locationService.location = nil
                        
                        waitUntil { (done) in
                            sut.didFetchWeatherData = { (result) in
                                if case .failure(let error) = result {
                                    expect(error).to(equal(RootViewModel.WeatherDataError.notAuthorizedToRequestLocation))
                                    done()
                                }
                            }
                            
                            sut.refresh()
                        }

                    }
                }
                
                
                context("when failed to fetch weatherData with invalid response") {
                    it("get noWeatherDataAvailable error") {
                        networkService.data = "data".data(using: .utf8)
                        
                        waitUntil { (done) in
                            sut.didFetchWeatherData = { (result) in
                                if case .failure(let error) = result {
                                    expect(error).to(equal(RootViewModel.WeatherDataError.noWeatherDataAvailable))
                                    done()
                                }
                            }
                            
                            sut.refresh()
                        }

                    }
                }
                
                context("when failed to fetch weatherData with failed request") {
                    it("get noWeatherDataAvailable error") {
                        networkService.error = NSError(domain: "com.cyberhex.network.service", code: 1, userInfo: nil)
                        
                        waitUntil { (done) in
                            sut.didFetchWeatherData = { (result) in
                                if case .failure(let error) = result {
                                    expect(error).to(equal(RootViewModel.WeatherDataError.noWeatherDataAvailable))
                                    done()
                                }
                            }
                            
                            sut.refresh()
                        }

                    }
                }
                
                context("when application will enter foreground with not timestamp") {
                    it("should refresh") {
                        waitUntil(timeout: 2) { (done) in
                            UserDefaults.standard.removeObject(forKey: "didFetchWeatherData")
                            sut.didFetchWeatherData = { (result) in
                                done()
                            }
                            
                            NotificationCenter.default.post(name: UIApplication.willEnterForegroundNotification, object: nil)
                        }
                    }
                }
                
                context("when application will enter foreground for more than 10 mins") {
                    it("should refresh") {
                        waitUntil(timeout: 2) { (done) in
                            sut.didFetchWeatherData = { (result) in
                                done()
                            }
                            
                            NotificationCenter.default.post(name: UIApplication.willEnterForegroundNotification, object: nil)
                        }

                    }
                }
            }
        }
    }

}
