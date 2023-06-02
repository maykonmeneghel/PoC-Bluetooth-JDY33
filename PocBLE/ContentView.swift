import SwiftUI

struct ContentView: View {
    
    let bluetoothService = BluetoothService()
    
    @State private var message: String = ""
    
    var body: some View {
        VStack {
            TextField("Digite uma mensagem", text: $message)
                .font(.body)
                .padding()
            
            Button(action: {
                bluetoothService.sendMessage(message)
            }) {
                Text("Enviar")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            bluetoothService.startScanningDevices()
        }
        .onDisappear {
            bluetoothService.stopScanningDevices()
        }
        .padding()
    }
}
