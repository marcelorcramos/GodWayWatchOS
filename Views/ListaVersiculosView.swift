import SwiftUI

struct ListaVersiculosView: View {
    let categoria: String
    let versiculos: [Versiculo]
    @ObservedObject var viewModel: VersiculoViewModel
    
    var body: some View {
        List(versiculos) { versiculo in
            NavigationLink(destination: TelaVersiculoView(
                versiculo: versiculo,
                viewModel: viewModel
            )) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(versiculo.referencia)
                        .font(.headline)
                        .lineLimit(1)
                    Text("\(versiculo.livro) \(versiculo.capitulo):\(versiculo.versiculo)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle(categoria)
        .navigationBarTitleDisplayMode(.inline)
    }
}
