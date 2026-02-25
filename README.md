# 📱 **GodWay - README**

## Aplicação Cristã para Apple Watch

---

## 📋 **Descrição do Projeto**

**GodWay** é uma aplicação para Apple Watch desenvolvida em SwiftUI que oferece versículos bíblicos categorizados por emoções e necessidades do dia a dia. O objetivo é proporcionar conforto espiritual rápido e acessível diretamente no pulso do utilizador.

---

## ✨ **Funcionalidades**

| Funcionalidade | Descrição |
|----------------|-----------|
| **Versículo do Dia** | Versículo aleatório que muda diariamente |
| **Categorias Temáticas** | Versículos organizados por: Conexão com Deus, Ansiedade, Força, Gratidão, Esperança, Paz, Perdão |
| **Favoritos** | Guardar versículos preferidos com persistência local |
| **Design Adaptado** | Interface otimizada para o ecrã do Apple Watch |
| **Feedback Tátil** | Resposta tátil ao favoritar versículos |

---

## 🛠️ **Tecnologias Utilizadas**

- **Swift 5** - Linguagem de programação
- **SwiftUI** - Framework de interface
- **watchOS** - Plataforma alvo
- **JSON** - Armazenamento de dados
- **FileManager** - Persistência local de favoritos
- **MVVM** - Arquitetura do projeto

---

## 📁 **Estrutura do Projeto**

```
GodWay/
├── Models/
│   └── Versiculo.swift          # Modelo de dados do versículo
├── ViewModels/
│   └── VersiculoViewModel.swift  # Lógica e estado da aplicação
├── Views/
│   ├── ContentView.swift          # Ecrã principal com categorias
│   ├── ListaVersiculosView.swift  # Lista de versículos por categoria
│   ├── TelaVersiculoView.swift    # Visualização detalhada do versículo
│   └── TelaFavoritosView.swift    # Lista de versículos favoritos
├── Services/
│   └── JSONManager.swift          # Gestão de leitura/escrita JSON
└── Data/
    └── versiculos.json            # Base de dados de versículos
```

---

## 🚀 **Como Executar**

### Pré-requisitos
- macOS com Xcode 14+
- Apple Watch Simulator ou dispositivo físico

### Passos
1. Clone o repositório
2. Abra o ficheiro `GodWay.xcodeproj` no Xcode
3. Selecione o esquema para Apple Watch
4. Pressione `Cmd + R` para executar no simulador

---

## 📊 **Fluxo da Aplicação**

```
Ecrã Principal
    │
    ├── Categorias → Lista de Versículos → Detalhe do Versículo → Favoritar
    │
    └── Favoritos → Lista de Favoritos → Detalhe do Versículo → Remover
```

---

## 🎨 **Design e Cores**

| Categoria | Cor |
|-----------|-----|
| Conexão com Deus | Roxo |
| Ansiedade | Laranja |
| Força | Vermelho |
| Gratidão | Verde |
| Esperança | Azul |
| Paz | Verde Azulado |
| Perdão | Índigo |

---

## 💾 **Persistência de Dados**

- **Versículos:** Lidos do ficheiro `versiculos.json` incluído no bundle
- **Favoritos:** Guardados no diretório Documents do app em `favoritos.json`
- Os favoritos persistem após fechar a aplicação

---

## 🎯 **Funcionalidades Futuras**

- [ ] Sincronização com iPhone via iCloud
- [ ] Mais categorias e versículos
- [ ] Pesquisa por palavras-chave
- [ ] Versículo diário com notificação
- [ ] Modo escuro automático

---

## 📝 **Notas para Desenvolvimento**

- O projeto segue a arquitetura **MVVM** (Model-View-ViewModel)
- Usa **Singleton** para o gestor de JSON
- Implementa **feedback tátil** específico do watchOS
- Design responsivo adaptado ao ecrã do Apple Watch

---

## 👨‍💻 **Autores**

Projeto acadêmico desenvolvido para a disciplina de SwiftUI.

---

## 📄 **Licença**

Este projeto é para fins educacionais.

---

**GodWay - A Palavra certa para o momento certo** 🙏
