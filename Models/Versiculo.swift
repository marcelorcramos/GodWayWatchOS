import Foundation

struct Versiculo: Identifiable, Codable{
    let id: String
    let texto: String
    let referencia: String
    let categoria: String
    let livro: String
    let capitulo: Int
    let versiculo: Int
    
    var tituloParaLista: String {
        return "\(referencia) - \(livro)"
    }
}

struct VersiculosData: Codable {
    let versiculos: [Versiculo]
}

struct FavoritosData: Codable {
    let favoritos: [Versiculo]
}
