//Detalhe do versículo
import SwiftUI
import WatchKit

struct TelaVersiculoView: View {
    let versiculo: Versiculo
    @ObservedObject var viewModel: VersiculoViewModel
    let corTema: Color
    @State private var isFavorito: Bool = false
    @State private var mostrarAlerta = false
    @State private var escalaAnimacao: CGFloat = 1.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                VStack(spacing: 8) {
                    ZStack {
                        // Efeito de brilho
                        Circle()
                            .fill(corTema.opacity(0.3))
                            .frame(width: 80, height: 80)
                            .scaleEffect(escalaAnimacao)
                            .opacity(2 - escalaAnimacao)
                            .animation(
                                Animation.easeInOut(duration: 1.5)
                                    .repeatForever(autoreverses: true),
                                value: escalaAnimacao
                            )
                        
                        // Ícone principal
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [corTema, corTema.opacity(0.5)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: iconName(for: versiculo.categoria))
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    
                    Text(versiculo.categoria)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(corTema)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(corTema.opacity(0.2))
                        .cornerRadius(12)
                }
                .padding(.top, 8)
                .onAppear {
                    escalaAnimacao = 1.2
                }
                
                // Versículo em card
                VStack(spacing: 12) {
                    Text("📖")
                        .font(.title)
                    
                    Text(versiculo.texto)
                        .font(.body)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Divider()
                        .background(corTema.opacity(0.5))
                        .padding(.horizontal, 20)
                    
                    Text(versiculo.referencia)
                        .font(.headline)
                        .foregroundColor(corTema)
                    
                    Text("\(versiculo.livro) \(versiculo.capitulo):\(versiculo.versiculo)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.gray.opacity(0.2),
                                    corTema.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        colors: [corTema.opacity(0.5), .clear],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                )
                
                // Botão Favoritar
                Button(action: toggleFavorito) {
                    HStack {
                        Image(systemName: isFavorito ? "heart.fill" : "heart")
                            .font(.title3)
                            .scaleEffect(isFavorito ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isFavorito)
                        
                        Text(isFavorito ? "Favoritado" : "Favoritar")
                            .font(.body)
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            colors: isFavorito ? [.red, .pink] : [corTema, corTema.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 8)
            }
            .padding(.horizontal, 8)
        }
        .alert("Favoritos", isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(isFavorito ? "✨ Versículo favoritado com amor!" : "💔 Versículo removido dos favoritos")
        }
        .onAppear {
            isFavorito = viewModel.isFavorito(versiculo)
        }
    }
    
    private func toggleFavorito() {
        withAnimation {
            if isFavorito {
                viewModel.desfavoritar(versiculo)
            } else {
                viewModel.favoritar(versiculo)
            }
            isFavorito.toggle()
            mostrarAlerta = true
        }
        
        WKInterfaceDevice.current().play(isFavorito ? .success : .click)
    }
    
    private func iconName(for categoria: String) -> String {
        switch categoria {
        case "Conexão": return "heart.circle.fill"
        case "Ansiedade": return "exclamationmark.triangle.fill"
        case "Força": return "bolt.shield.fill"
        case "Gratidão": return "hands.sparkles.fill"
        default: return "book.circle.fill"
        }
    }
}
