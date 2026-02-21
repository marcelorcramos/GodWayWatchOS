import SwiftUI

struct ListaVersiculosView: View {
    let categoria: String
    let versiculos: [Versiculo]
    @ObservedObject var viewModel: VersiculoViewModel
    let corTema: Color
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header da categoria
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(corTema.opacity(0.2))
                            .frame(width: 60, height: 60)
                        
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [corTema, .white],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: iconName(for: categoria))
                            .font(.largeTitle)
                            .foregroundColor(corTema)
                    }
                    
                    Text(categoria)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(corTema)
                    
                    Text("\(versiculos.count) versículos")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [corTema.opacity(0.1), .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                // Lista de versículos
                LazyVStack(spacing: 12) {
                    ForEach(versiculos) { versiculo in
                        NavigationLink(destination: TelaVersiculoView(
                            versiculo: versiculo,
                            viewModel: viewModel,
                            corTema: corTema
                        )) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(versiculo.referencia)
                                        .font(.headline)
                                        .foregroundColor(corTema)
                                    
                                    Text(versiculo.texto)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                Spacer()
                                
                                if viewModel.isFavorito(versiculo) {
                                    Image(systemName: "heart.fill")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                } else {
                                    Image(systemName: "chevron.right")
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(corTema.opacity(0.3), lineWidth: 1)
                                    )
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 8)
            }
        }
        .navigationTitle(categoria)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func iconName(for categoria: String) -> String {
        switch categoria {
        case "Conexão com Deus": return "heart.circle.fill"
        case "Ansiedade": return "exclamationmark.triangle.fill"
        case "Força": return "bolt.shield.fill"
        case "Gratidão": return "hands.sparkles.fill"
        default: return "book.circle.fill"
        }
    }
}
