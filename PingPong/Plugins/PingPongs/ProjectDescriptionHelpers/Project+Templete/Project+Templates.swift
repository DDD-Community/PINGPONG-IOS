import ProjectDescription
import Foundation

public extension Project {
    public static func makeAppModule(
        name: String,
        bundleId: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "Wonji Suh",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "16.0", devices: [.iphone]),
        setting: Settings,
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        entitlements: Entitlements? = nil,
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
            scripts: [.FirebaseCrashlyticsString],
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
        
        let widgetTarget = Target(
           name: "\(name)",
           platform: .iOS,
           product: .appExtension,
           bundleId: bundleId,
           deploymentTarget: deploymentTarget,
           infoPlist: infoPlist,
           sources: sources,
           resources: resources,
           entitlements: entitlements,
           scripts: [],
           dependencies: dependencies
           
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
    
    public static func makeAppWidgetModule(
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
        entitlements: Entitlements? = nil,
        scheme : [Scheme] = [ ]
    ) -> Project {
        let widgetTarget = Target(
            name: "WidgetExtension",
            platform: platform,
            product: .appExtension,
            bundleId: "\(bundleId).WidgetExtension",
            deploymentTarget: deploymentTarget,
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "$(PRODUCT_NAME)",
                "NSExtension": [
                    "NSExtensionPointIdentifier": "com.apple.widgetkit-extension",
                ],
            ]),
            sources: ["WidgetExtension/Sources/**"],
            resources: ["WidgetExtension/Resources/**"],
            entitlements: entitlements,
            scripts: [],
            dependencies: dependencies
        )
        
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
            dependencies: dependencies + [.target(name: "WidgetExtension")]
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
            dependencies: dependencies + [.target(name: "WidgetExtension")]
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
        
        let targets: [Target] = [appTarget, appDevTarget, testTarget, widgetTarget]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: setting,
            targets: targets,
            schemes: scheme
        )
    }

    
    public static func makeWidgetModule(
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
        entitlements: Entitlements? = nil,
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
        
        
        let targets: [Target] = [appTarget, appDevTarget]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: setting,
            targets: targets,
            schemes: scheme
        )
        
    }
    
    public static func makeFrameWorkModule(
        name: String,
        bundleId: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "Wonji Suh",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "16.0", devices: [.iphone]),
        setting: Settings,
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        entitlements: Entitlements? = nil,
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
      let version: String = "1.0.3"
      return version
  }

  public static func appBuildVersion() -> String {
      let buildVersion: String = "25"
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
