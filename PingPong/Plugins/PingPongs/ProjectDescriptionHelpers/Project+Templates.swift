import ProjectDescription
import Foundation




public extension Project {
    public static func makeModule(
        name: String,
        bundleId: String,
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
        
        let appTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: bundleId,
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
            bundleId: "\(bundleId)Dev",
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
            bundleId: "\(bundleId).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["\(name)Tests/Sources/**"],
            dependencies: [.target(name: name)]
        )
        
        
        
        let targets: [Target] = [appTarget, appDevTarget,testTarget]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: setting,
            targets: targets,
            schemes: scheme
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


extension String {
  public static func appVersion() -> String {
      let version: String = "1.0.0"
      return version
  }

  public static func appBuildVersion() -> String {
      let buildVersion: String = "10"
      return buildVersion
  }
    
    public static func mainBundleID() -> String {
        let bundleID = "com.pingpong.co"
        return bundleID
    }
    
    public static func appBundleID(name: String) -> String {
        let bundleID = "com.pingpong.co."
        return bundleID+name
    }
}
