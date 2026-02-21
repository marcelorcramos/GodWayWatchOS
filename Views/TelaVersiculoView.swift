import SwiftUI
import WatchKit

struct TelaVersiculoView: View {
    let versiculo: Versiculo
    @ObservedObject var viewModel: VersiculoViewModel
    @State private var isFavorito: Bool = false
    @State private var mostrarAlerta = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Ícone da categoria
                Image(systemName: iconName(for: versiculo.categoria))
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .padding(.top)
                
                // Versículo
                Text(versiculo.texto)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Referência
                Text(versiculo.referencia)
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Divider()
                    .padding(.vertical, 8)
                
                // Botão Favoritar (único botão)
                Button(action: toggleFavorito) {
                    HStack {
                        Image(systemName: isFavorito ? "heart.fill" : "heart")
                            .font(.title3)
                        Text(isFavorito ? "Favoritado" : "Favoritar")
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFavorito ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
            }
        }
        .alert("Favoritos", isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(isFavorito ? "Versículo adicionado!" : "Versículo removido!")
        }
        .onAppear {
            isFavorito = viewModel.isFavorito(versiculo)
        }
    }
    
    private func toggleFavorito() {
        if isFavorito {
            viewModel.desfavoritar(versiculo)
        } else {
            viewModel.favoritar(versiculo)
        }
        isFavorito.toggle()
        mostrarAlerta = true
        
        // Feedback tátil
        WKInterfaceDevice.current().play(.click)
    }
    
    private func iconName(for categoria: String) -> String {
        switch categoria {
        case "Conexão com Deus": return "heart.circle.fill"
        case "Ansiedade": return "exclamationmark.circle.fill"
        case "Força": return "bolt.circle.fill"
        case "Gratidão": return "star.circle.fill"
        default: return "book.circle.fill"
        }
    }
}
