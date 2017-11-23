//
//  Move.swift
//  projectTDD
//
//  Created by Haikal Rios on 16/11/2017.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import Foundation

enum Genere: CustomStringConvertible{
    
    case Animation
    case Action
    case Indie
    case Porn
    
    var description: String{
        get{
            switch self {
            case .Action: return "Action"
            case .Animation: return "Animation"
            case .Indie: return "Indie"
            case .Porn: return "Porn"
            }
        }
    }
    
}

struct Movie {
    var title : String
    var genere : Genere
    
    static func loadMovies() -> [Movie]{
        return [
        Movie(title: "Aprendendo Swift", genere: .Animation),
        Movie(title: "Não sabe o que faz", genere: .Indie),
        Movie(title: "Quem quer ser um desesperado", genere: .Porn),
        Movie(title: "Sorrindo pra um careca", genere: .Action)
        ]
    }
    
}
