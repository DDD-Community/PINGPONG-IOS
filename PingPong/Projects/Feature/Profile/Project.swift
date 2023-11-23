import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeFramsWorkModule(
name: "Profile",
bundleId: .appBundleID(name: ".Profile"),
product: .staticFramework,
setting:  .appBaseSetting,
dependencies: [
        .core(implements: .Common),
        .core(implements: .Authorization),
        .design(implements: .DesignSystem),
        .feature(implements: .Search),
        .domain(implements: .Model),
        .domain(implements: .Service)
        
],
sources: ["Sources/**"]
)
