//Ecrã principal
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = VersiculoViewModel()
    @State private var selectedTab = 0
    @State private var versiculoDoDia: Versiculo?
    
    // Cores temáticas para cada categoria
    let categoriaCores: [String: Color] = [
        "Conexão": .purple,
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
                    VStack(spacing: 16) {
                        // Header
                        Text("GODWAY")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(.top, 8)
                        
                        // VERSÍCULO DO DIA
                        if let versiculo = versiculoDoDia {
                            VStack(spacing: 8) {
                                Text("VERSÍCULO DO DIA")
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    .tracking(1)
                                
                                Text(versiculo.texto)
                                    .font(.footnote)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 12)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                Text(versiculo.referencia)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(categoriaCores[versiculo.categoria] ?? .blue)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(
                                                LinearGradient(
                                                    colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 1
                                            )
                                    )
                            )
                            .padding(.horizontal, 8)
                            .padding(.bottom, 4)
                        }
                        
                        // Grid de categorias
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
                                            .lineLimit(1)
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
                .onAppear {
                    carregarVersiculoDoDia()
                }
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
        case "Conexão": return "heart.circle.fill"
        case "Ansiedade": return "exclamationmark.triangle.fill"
        case "Força": return "bolt.shield.fill"
        case "Gratidão": return "hands.sparkles.fill"
        case "Esperança": return "leaf.fill"
        case "Paz": return "dove.fill"
        case "Perdão": return "heart.slash.fill"
        default: return "book.circle.fill"
        }
    }
    
    private func carregarVersiculoDoDia() {
        let hoje = Calendar.current.startOfDay(for: Date())
        let seed = Int(hoje.timeIntervalSince1970)
        
        // Gerar número aleatório baseado na data
        srand48(seed)
        let randomIndex = Int(drand48() * Double(viewModel.todosVersiculos.count))
        
        if randomIndex < viewModel.todosVersiculos.count {
            versiculoDoDia = viewModel.todosVersiculos[randomIndex]
        } else if !viewModel.todosVersiculos.isEmpty {
            versiculoDoDia = viewModel.todosVersiculos.first
        }
    }
}
