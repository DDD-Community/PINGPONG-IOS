//
//  Module.swift
//  Manifests
//
//  Created by 서원지 on 11/4/23.
//

import ProjectDescription
import Foundation


let name = Template.Attribute.required("name")
let author: Template.Attribute = .required("author")
let currentDate: Template.Attribute = .optional("currentDate", default: defaultDate)
let year: Template.Attribute = .optional("year", default: defaultYear)

let template = Template(
    description: "A template for a new modules",
    attributes: [
        name,
        author,
        currentDate,
        year
    ],
    items: ModuleTemplate.allCases.map { $0.item }
    
)


enum ModuleTemplate: CaseIterable {
    case project
    case baseFile
    case testProject
    
    var item: Template.Item {
        switch self {
        case .project:
            return .file(path: .basePath + "/Project.swift", templatePath: "Project.stencil")
        case .baseFile:
            return .file(path: .basePath + "/Sources/Base.swift", templatePath: "base.stencil")
            
        case .testProject:
            return .file(path:  .testBasePath + "/Sources/Test.swift", templatePath: "test.stencil")
            
       
            
        }
    }
}


extension String {
    static var basePath: Self {
        return "Projects/Feature/\(name)"
    }
    static var testBasePath: Self {
        return "Projects/Feature/\(name)/\(name)Tests"
    }
}


var defaultDate: String {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    let formattedDate = formatter.string(from: today)
    return formattedDate
}

var defaultYear: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: Date())
}


