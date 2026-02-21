import Foundation

class JSONManager {
    static let shared = JSONManager() // Singleton para facilitar o acesso
    
    private init() {}
    
    // MARK: - Leitura do arquivo de versículos (do bundle)
    func carregarVersiculos() -> [Versiculo] {
        guard let url = Bundle.main.url(forResource: "versiculos", withExtension: "json") else {
            print("Arquivo versiculos.json não encontrado no bundle")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let versiculosData = try decoder.decode(VersiculosData.self, from: data)
            return versiculosData.versiculos
        } catch {
            print("Erro ao carregar versículos: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Gerenciamento de Favoritos (salvos no diretório Documents)
    
    private func getFavoritosURL() -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsDirectory.appendingPathComponent("favoritos.json")
    }
    
    func carregarFavoritos() -> [Versiculo] {
        guard let url = getFavoritosURL(),
              FileManager.default.fileExists(atPath: url.path) else {
            // Se o arquivo não existe, retorna lista vazia
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let favoritosData = try decoder.decode(FavoritosData.self, from: data)
            return favoritosData.favoritos
        } catch {
            print("Erro ao carregar favoritos: \(error.localizedDescription)")
            return []
        }
    }
    
    func salvarFavoritos(_ favoritos: [Versiculo]) {
        guard let url = getFavoritosURL() else { return }
        
        do {
            let favoritosData = FavoritosData(favoritos: favoritos)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // Para o JSON ficar legível
            let data = try encoder.encode(favoritosData)
            try data.write(to: url)
            print("Favoritos salvos em: \(url.path)")
        } catch {
            print("Erro ao salvar favoritos: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Método para debug (opcional)
    func printCaminhoFavoritos() {
        if let url = getFavoritosURL() {
            print("Arquivo de favoritos: \(url.path)")
        }
    }
}
