import SwiftUI

struct ConfigView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Properties
    @State var text: String = ""
    var action: (String) -> Void
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            TextField("Digite o ID", text: $text)
                .font(.body)
            Button {
                action(text)
                dismiss()
            } label: {
                Text("Cadastrar")
            }

        }
        
        
        
    }
}
