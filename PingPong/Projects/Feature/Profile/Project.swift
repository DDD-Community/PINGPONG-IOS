import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
name: "Profile",
bundleId: .appBundleID(name: ".Profile"),
product: .staticFramework,
setting:  .appBaseSetting,
dependencies: [
        .core(implements: .Common),
        .core(implements: .Authorization),
        .design(implements: .DesignSystem),
        .domain(implements: .Model),
        .domain(implements: .Service)
        
],
sources: ["Sources/**"]
)
