import SwiftUI

struct TelaFavoritosView: View {
    @ObservedObject var viewModel: VersiculoViewModel
    let categoriaCores: [String: Color]
    @State private var editMode = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header dos favoritos
                VStack(spacing: 8) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.red, .pink, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("Meus Favoritos")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("\(viewModel.favoritos.count) versículos guardados")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [.red.opacity(0.1), .pink.opacity(0.05)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                if viewModel.favoritos.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 40))
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Text("Nenhum favorito ainda")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text("Toque no coração ao ler um versículo para adicioná-lo aqui")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.vertical, 30)
                } else {
                    // Botão de editar modo
                    HStack {
                        Spacer()
                        Button(action: { editMode.toggle() }) {
                            HStack {
                                Image(systemName: editMode ? "checkmark.circle.fill" : "pencil.circle.fill")
                                Text(editMode ? "Concluído" : "Editar")
                            }
                            .font(.caption)
                            .foregroundColor(editMode ? .green : .blue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(editMode ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 12)
                    
                    // Lista de favoritos
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.favoritos) { versiculo in
                            let cor = categoriaCores[versiculo.categoria] ?? .blue
                            
                            HStack {
                                if editMode {
                                    Button(action: {
                                        withAnimation {
                                            viewModel.desfavoritar(versiculo)
                                            WKInterfaceDevice.current().play(.click)
                                        }
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .font(.title3)
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                                NavigationLink(destination: TelaVersiculoView(
                                    versiculo: versiculo,
                                    viewModel: viewModel,
                                    corTema: cor
                                )) {
                                    HStack {
                                        // Ícone pequeno da categoria
                                        ZStack {
                                            Circle()
                                                .fill(cor.opacity(0.2))
                                                .frame(width: 30, height: 30)
                                            
                                            Image(systemName: iconName(for: versiculo.categoria))
                                                .font(.caption)
                                                .foregroundColor(cor)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(versiculo.referencia)
                                                .font(.headline)
                                                .foregroundColor(cor)
                                            
                                            Text(versiculo.texto)
                                                .font(.caption2)
                                                .foregroundColor(.gray)
                                                .lineLimit(2)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(
                                                LinearGradient(
                                                    colors: [cor.opacity(0.5), .clear],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                ),
                                                lineWidth: 2
                                            )
                                    )
                            )
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
        }
        .navigationTitle("Favoritos")
        .navigationBarTitleDisplayMode(.inline)
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
}
