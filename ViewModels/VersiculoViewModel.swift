import Foundation
import Combine
import WatchKit

class VersiculoViewModel: ObservableObject {
    @Published var categorias: [String] = []
    @Published var versiculosPorCategoria: [String: [Versiculo]] = [:]
    @Published var favoritos: [Versiculo] = []
    
    private(set) var todosVersiculos: [Versiculo] = []
    
    private let jsonManager = JSONManager.shared
    private let userDefaults = UserDefaults.standard
    
    init() {
        carregarDados()
    }
    
    func carregarDados() {
        todosVersiculos = jsonManager.carregarVersiculos()
        
        favoritos = jsonManager.carregarFavoritos()

        organizarPorCategoria()
    }
    
    private func organizarPorCategoria() {
        let categoriasSet = Set(todosVersiculos.map { $0.categoria })
        categorias = Array(categoriasSet).sorted()
        
        for categoria in categorias {
            versiculosPorCategoria[categoria] = todosVersiculos.filter { $0.categoria == categoria }
        }
    }
    
    func favoritar(_ versiculo: Versiculo) {
        if !favoritos.contains(where: { $0.id == versiculo.id }) {
            favoritos.append(versiculo)
            jsonManager.salvarFavoritos(favoritos)
            WKInterfaceDevice.current().play(.click)
        }
    }
    
    func desfavoritar(_ versiculo: Versiculo) {
        favoritos.removeAll { $0.id == versiculo.id }
        jsonManager.salvarFavoritos(favoritos)
        WKInterfaceDevice.current().play(.click)
    }
    
    func isFavorito(_ versiculo: Versiculo) -> Bool {
        return favoritos.contains { $0.id == versiculo.id }
    }
    
    func buscarVersiculosPorCategoria(_ categoria: String) -> [Versiculo] {
        return versiculosPorCategoria[categoria] ?? []
    }
}
