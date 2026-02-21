import SwiftUI

struct TelaFavoritosView: View {
    @ObservedObject var viewModel: VersiculoViewModel
    @State private var editMode = false
    
    var body: some View {
        List {
            if viewModel.favoritos.isEmpty {
                Text("Nenhum versículo favoritado")
                    .foregroundColor(.gray)
                    .italic()
                    .multilineTextAlignment(.center)
                    .listRowBackground(Color.clear)
            } else {
                ForEach(viewModel.favoritos) { versiculo in
                    HStack {
                        if editMode {
                            Button(action: {
                                viewModel.desfavoritar(versiculo)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.trailing, 8)
                        }
                        
                        NavigationLink(destination: TelaVersiculoView(
                            versiculo: versiculo,
                            viewModel: viewModel
                        )) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(versiculo.referencia)
                                    .font(.headline)
                                    .lineLimit(1)
                                Text(versiculo.categoria)
                                    .font(.caption2)
                                    .foregroundColor(.blue)
                                Text(versiculo.texto)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
        }
        .navigationTitle {
            HStack {
                Text("Favoritos")
                Spacer()
                Button(action: {
                    editMode.toggle()
                }) {
                    Text(editMode ? "Concluído" : "Editar")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
