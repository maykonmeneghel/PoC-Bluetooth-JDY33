import SwiftUI

struct ContentView: View {
    
    let bluetoothService = BluetoothService()
    
    @State private var message: String = ""
    
    @State var isConnected: Bool = false
    
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(isConnected ? .green : .red)
            
            Button {
                isConnected.toggle()
            } label: {
                Text(isConnected ? "Disconnect" : "Connect")
                    .font(.body)
                    .foregroundColor(.primary)
            }
            .frame(width: 120, height: 40)
            .background(.secondary)
            .cornerRadius(20)
            
        }
        .onChange(of: isConnected, perform: { newValue in
            if newValue {
                bluetoothService.connect()
            } else {
                bluetoothService.disconnect()
            }
        })
//
//            TextField("Digite uma mensagem", text: $message)
//                .font(.body)
//                .padding()
//
//            Button(action: {
//                bluetoothService.sendMessage(message)
//            }) {
//                Text("Enviar")
//                    .font(.body)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .onAppear {
//            bluetoothService.startScanningDevices()
//        }
//        .onDisappear {
//            bluetoothService.stopScanningDevices()
//        }
//        .padding()
    }
}
