import SwiftUI

struct ContentView: View {
    
    // MARK: Properties
    
    let bluetoothService = BluetoothService()
    @State private var message: String = ""
    @State var isConnected: Bool = false
    @State var isOpened: Bool = false
    @State private var timer: Timer?
    @State private var timeRemaining: Int = 30
    
    // MARK: Body
    
    var body: some View {
        VStack() {
            Spacer()
            if isConnected { openDoorView }
            Spacer()
            HStack(spacing: 16) {
                indicatorView
                connectionButtonView
            }
        }
        .onChange(of: isConnected, perform: { newValue in
            if newValue {
                bluetoothService.connect()
            } else {
                bluetoothService.disconnect()
            }
        })
    }
    
    // MARK: Views
    
    private var indicatorView: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .frame(width: 12, height: 12)
            .foregroundColor(isConnected ? .green : .red)
    }
    
    private var connectionButtonView: some View {
        Button {
            resetTimer()
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
    
    private var openDoorView: some View {
        VStack {
            Button {
                bluetoothService.sendMessage("")
                isOpened = true
                startTimer()
            } label: {
                Image(systemName: isOpened ? "lock.open" : "lock")
                    .resizable()
                    .frame(width: isOpened ? 50 : 40, height: 55)
            }
            .disabled(timeRemaining < 30)
            
            if isOpened {
                Text("\(timeRemaining)")
                    .font(.body)
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                resetTimer()
            }
        }
    }
    
    private func resetTimer() {
        timeRemaining = 30
        isOpened = false
        timer?.invalidate()
    }
}
