import CoreBluetooth
import UIKit

/// Movesense related constants 
final public class Movesense {
    static public let MOVESENSE_SERVICES = [CBUUID(string: "61353090-8231-49cc-b57a-886370740041"),CBUUID(string: "fdf3")]
    static public let MOVESENSE_COLOR = UIColor(red:0.93, green:0.19, blue:0.14, alpha:1.0)

    static public let SYSTEM_MODE_PATH = "/System/Mode"
    static public let OLD_SYSTEM_MODE_PATH = "/Device/System/Mode"
    static public let TIME_PATH = "/Time"
    static public let INFO_PATH = "/Info"
    static public let ENERGY_PATH = "/System/Energy/Level"
    static public let BLE_PATH = "/Comm/Ble"
    static public let BLE_ADDR_PATH = BLE_PATH + "/Addr"
    static public let BLE_ADV_PATH = BLE_PATH + "/Adv"
    static public let BLE_ADV_SETTINGS_PATH = BLE_ADV_PATH + "/Settings"
    static public let UART_PATH = "/System/Settings/UartOn"
    static public let POWER_OFF_PATH = "/System/Settings/PowerOffAfterReset"
    static public let ACCEL_PATH = "/Meas/Acc"
    static public let ACCEL_INFO_PATH = ACCEL_PATH + "/Info"
    static public let ACCEL_CONFIG_PATH = ACCEL_PATH + "/Config"
    static public let MAGN_PATH = "/Meas/Magn"
    static public let MAGN_INFO_PATH = MAGN_PATH + "/Info"
    static public let MAGN_CONFIG_PATH = MAGN_PATH + "/Config"
    static public let GYRO_PATH = "/Meas/Gyro"
    static public let GYRO_INFO_PATH = GYRO_PATH + "/Info"
    static public let GYRO_CONFIG_PATH = GYRO_PATH + "/Config"
    static public let HR_PATH = "/Meas/HR"
    static public let HR_INFO_PATH = HR_PATH + "/Info"
    static public let TEMPERATURE_PATH = "/Meas/Temp"
    static public let TEMPERATURE_INFO_PATH = TEMPERATURE_PATH + "/Info"
    static public let MANUF_PRODUCT_DATA_PATH = "/Misc/Manufacturing/ProductData"
    static public let MANUF_CALIBRATION_DATA_PATH = "/Misc/Manufacturing/CalibrationData"
    static public let GEAR_ID_PATH = "/Misc/Gear/Id"
    static public let LED_PATH = "/Component/Led"

    static public let LOGBOOK_PATH = "/Mem/Logbook"
    static public let LOGBOOK_LOGGING_PATH = LOGBOOK_PATH + "/Logging"
    static public let LOGBOOK_ISOPEN_PATH = LOGBOOK_PATH + "/IsOpen"
    static public let LOGBOOK_ISFULL_PATH = LOGBOOK_PATH + "/IsFull"
    static public let LOGBOOK_UNSYNCRONISED_LOGS_PATH = LOGBOOK_PATH + "/UnsynchronisedLogs"
    static public let LOGBOOK_ENTRIES_PATH = LOGBOOK_PATH + "/Entries"
    static public let LOGBOOK_LOG_PATH = LOGBOOK_PATH + "/Log"

    static public let DATALOGGER_CONFIG_PATH = "/Mem/DataLogger/Config"
    static public let DATALOGGER_STATE_PATH = "/Mem/DataLogger/State"
}
