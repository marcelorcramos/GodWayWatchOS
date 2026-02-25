import Foundation
import Combine
import WatchKit

class VersiculoViewModel: ObservableObject {
    @Published var categorias: [String] = []
    @Published var versiculosPorCategoria: [String: [Versiculo]] = [:]
    @Published var favoritos: [Versiculo] = []
    
    // Tornar esta propriedade pública para o ContentView acessar
    private(set) var todosVersiculos: [Versiculo] = []
    
    private let jsonManager = JSONManager.shared
    private let userDefaults = UserDefaults.standard
    
    init() {
        carregarDados()
    }
    
    func carregarDados() {
        // Carrega versículos do JSON no bundle
        todosVersiculos = jsonManager.carregarVersiculos()
        
        // Carrega favoritos do JSON no Documents
        favoritos = jsonManager.carregarFavoritos()
        
        // Organiza por categoria
        organizarPorCategoria()
    }
    
    private func organizarPorCategoria() {
        // Extrai categorias únicas
        let categoriasSet = Set(todosVersiculos.map { $0.categoria })
        categorias = Array(categoriasSet).sorted()
        
        // Agrupa versículos por categoria
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
