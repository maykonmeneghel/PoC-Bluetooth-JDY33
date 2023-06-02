import CoreBluetooth
import Foundation

class BluetoothService: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    private var centralManager: CBCentralManager?
    private var characteristic: CBCharacteristic?
    private var peripheral: CBPeripheral?
    private var scannedDevices: [CBPeripheral] = []
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func connect() {
        guard let peripheral = peripheral else { return }
        centralManager?.connect(peripheral, options: nil)
        print("Bluetooth is connected..")
    }
    
    func disconnect() {
        guard let peripheral = peripheral else { return }
        centralManager?.cancelPeripheralConnection(peripheral)
        print("Bluetooth is disconnected..")
    }
    
    func startScanningDevices() {
        scannedDevices.removeAll()
        centralManager?.scanForPeripherals(withServices: nil)
    }
    
    func stopScanningDevices() {
        centralManager?.stopScan()
    }
    
    func sendMessage(_ message: String) {
        guard let peripheral = peripheral else {
            print("Nenhum dispositivo Bluetooth conectado.")
            return
        }
        
        if let data = message.data(using: .utf8), let characteristic = characteristic {
            peripheral.writeValue(data, for: characteristic, type: .withoutResponse)
        }
    }
    
    // MARK: - CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("Bluetooth está desativado ou não suportado.")
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if peripheral.name == " IOS POCKET MARKET" {
            self.peripheral = peripheral
            self.peripheral?.delegate = self
//            centralManager?.connect(self.peripheral!, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }
    
    // MARK: - CBPeripheralDelegate
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }

        for characteristic in characteristics {
            if characteristic.uuid == CBUUID(string: "FFE2") {
                self.characteristic = characteristic
                break
            }
        }
    }
}
