import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = VersiculoViewModel()
    @State private var selectedTab = 0
    
    // Cores temáticas para cada categoria
    let categoriaCores: [String: Color] = [
        "Conexão com Deus": .purple,
        "Ansiedade": .orange,
        "Força": .red,
        "Gratidão": .green,
        "Esperança": .blue,
        "Paz": .teal,
        "Perdão": .indigo
    ]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Aba de Categorias
            NavigationStack {
                ScrollView {
                    VStack(spacing: 12) {
                        // Header com gradiente
                        VStack(spacing: 4) {
                            Image(systemName: "book.closed.fill")
                                .font(.largeTitle)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            Text("GodWay")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                            Text("Sua paz em cada pulso")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                        
                        // Grid de categorias em 2 colunas
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(viewModel.categorias, id: \.self) { categoria in
                                let versiculos = viewModel.buscarVersiculosPorCategoria(categoria)
                                let cor = categoriaCores[categoria] ?? .blue
                                
                                NavigationLink(destination: ListaVersiculosView(
                                    categoria: categoria,
                                    versiculos: versiculos,
                                    viewModel: viewModel,
                                    corTema: cor
                                )) {
                                    VStack(spacing: 8) {
                                        ZStack {
                                            Circle()
                                                .fill(cor.opacity(0.2))
                                                .frame(width: 50, height: 50)
                                            
                                            Circle()
                                                .stroke(
                                                    LinearGradient(
                                                        colors: [cor, cor.opacity(0.5)],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    ),
                                                    lineWidth: 2
                                                )
                                                .frame(width: 50, height: 50)
                                            
                                            Image(systemName: iconName(for: categoria))
                                                .font(.title2)
                                                .foregroundColor(cor)
                                        }
                                        
                                        Text(categoria)
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                            .foregroundColor(.primary)
                                        
                                        Text("\(versiculos.count)")
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 2)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(8)
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.gray.opacity(0.1))
                                            .shadow(color: cor.opacity(0.3), radius: 4, x: 0, y: 2)
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                }
                .navigationBarHidden(true)
            }
            .tag(0)
            
            // Aba de Favoritos
            NavigationStack {
                TelaFavoritosView(viewModel: viewModel, categoriaCores: categoriaCores)
            }
            .tag(1)
        }
        .tabViewStyle(.page)
        .ignoresSafeArea(.container, edges: .bottom)
    }
    
    func iconName(for categoria: String) -> String {
        switch categoria {
        case "Conexão com Deus": return "heart.circle.fill"
        case "Ansiedade": return "exclamationmark.triangle.fill"
        case "Força": return "bolt.shield.fill"
        case "Gratidão": return "hands.sparkles.fill"
        case "Esperança": return "leaf.fill"
        case "Paz": return "dove.fill"
        case "Perdão": return "heart.slash.fill"
        default: return "book.circle.fill"
        }
    }
}
