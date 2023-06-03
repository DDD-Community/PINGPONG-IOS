import ProjectDescription


let bundleID = "com.pingpong.co"
let buildVersion = "1.0.0"
let buildNumbers = "10"


public extension Project {
    public static func makeModule(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "Wonji Suh",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "16.4", devices: [.iphone]),
        setting: Settings,
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        entitlements: Path? = nil,
        scheme : [Scheme] = [ ]
        
    ) -> Project {
        let settings: Settings = .settings(
            base: projectSetting,
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ], defaultSettings: .recommended)
        
        let appTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: "\(bundleID)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: [],
            dependencies: dependencies
            
        )
        
        
        let appDevTarget = Target(
            name: "\(name)-Dev",
            platform: platform,
            product: product,
            bundleId: "\(bundleID)Dev",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: [],
            dependencies: dependencies
            
        )
        
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(bundleID).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["\(name)Tests/Sources/**"],
            dependencies: [.target(name: name)]
        )
        
        let realseScheme = Scheme.makeScheme(target: .release, name: "\(name) - Release")
        
        let debugScheme = Scheme.makeScheme(target: .debug, name: "\(name) - Dev")
        
        let schemes: [Scheme] = [realseScheme, debugScheme ]
        
        let targets: [Target] = [appTarget, appDevTarget,testTarget]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: setting,
            targets: targets,
            schemes: schemes
        )
    }
    
}


extension Scheme {
    public static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
    
}

