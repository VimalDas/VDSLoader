import PackageDescription

let package = Package(name: "VDSLoader",
                      platforms: [.iOS(.v10)],
                      products: [.library(name: "VDSLoader",
                                          targets: ["VDSLoader"])],
                      targets: [.target(name: "VDSLoader",
                                        path: "Source")],
                      swiftLanguageVersions: [.v4])
