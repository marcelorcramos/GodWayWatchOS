import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = VersiculoViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Aba de Categorias
            NavigationStack {
                List(viewModel.categorias, id: \.self) { categoria in
                    let versiculos = viewModel.buscarVersiculosPorCategoria(categoria)
                    
                    NavigationLink(destination: ListaVersiculosView(
                        categoria: categoria,
                        versiculos: versiculos,
                        viewModel: viewModel
                    )) {
                        HStack {
                            Image(systemName: iconName(for: categoria))
                                .font(.title3)
                            Text(categoria)
                                .font(.body)
                            Spacer()
                            Text("\(versiculos.count)")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
                .navigationTitle("GodWay")
            }
            .tag(0)
            
            // Aba de Favoritos
            NavigationStack {
                TelaFavoritosView(viewModel: viewModel)
            }
            .tag(1)
        }
        .tabViewStyle(.page) // Estilo de página para watchOS
    }
    
    func iconName(for categoria: String) -> String {
        switch categoria {
        case "Conexão com Deus": return "heart.circle"
        case "Ansiedade": return "exclamationmark.circle"
        case "Força": return "bolt.circle"
        case "Gratidão": return "star.circle"
        default: return "book.circle"
        }
    }
}
