//
//  Log.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation

struct Log {
    typealias WriteHandler = (Log.Level, String, String, Int, Any?, DispatchQueue?) -> Void
    fileprivate static let timeFormat = DateFormatter().then { $0.dateFormat = "YYYY/MM/dd-HH:mm:ss.SSS" }

    fileprivate static let consoleQueue = DispatchQueue(label: "console-log-queue")
    fileprivate static let fileoutQueue = DispatchQueue(label: "file-log-queue")

    public static let fileName = "cowayHT_log.txt"
    static var isUploading = false

    fileprivate static let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent(Log.fileName)

    fileprivate static let isEnabledConsole = true
    fileprivate static var isEnabledFile: Bool {
#if !RELEASE
        return true
#else
        return false
#endif
    }

    fileprivate static let makeFormat: (Log.Level, String, String, Int, Any?) -> String = {
        level, file, function, line, message in

        let className = file[..<file.index(file.reversed().firstIndex(of: ".")!.base, offsetBy: -1)]
        var log = String()
        if let message = message {
           log = "\(className).\(function):\(line) - \(message)"
        } else {
           log = "\(className).\(function):\(line)"
        }
        return "\(Log.timeFormat.string(from: Date())) \(level.consoleSymbol) \(log)"
    }

    fileprivate static let writeConsole: WriteHandler = { level, file, function, line, message, queue in
        let msg = makeFormat(level, file, function, line, message)
        let execute: () -> Void = {
            print(msg)
        }
        if let queue = queue {
            queue.async(execute: execute)
        } else {
            execute()
        }
        if isEnabledFile {
            writeFile(msg, fileoutQueue)
        }
    }

    fileprivate static let writeFile: (String, DispatchQueue?) -> Void = { msg, queue in
        if let queue = queue {
            queue.async {
                if !FileManager.default.fileExists(atPath: fileURL.path) {
                    FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
                }

                let displayText = "\(msg) \n".data(using: String.Encoding.utf8)
                if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
                    defer {
                        fileHandle.closeFile()
                    }
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(displayText!)
                }
            }
        }
    }

    fileprivate enum Destination {
        case console
        case file

        func write(_ level: Log.Level, _ file: String, _ function: String, _ line: Int, _ message: Any? = nil) {
            Log.writeConsole(level, (file as NSString).lastPathComponent, function, line, message, Log.consoleQueue)
        }
    }

    enum Level {
        case verbose
        case debug
        case info
        case warning
        case error

        var consoleSymbol: String {
            switch self {
            case .verbose:  return "💬"
            case .debug:    return "ℹ️"
            case .info:     return "✅"
            case .warning:  return "⚠️"
            case .error:    return "❌"
            }
        }

        var fileSymbol: String {
            switch self {
            case .verbose:  return "V"
            case .debug:    return "D"
            case .info:     return "I"
            case .warning:  return "W"
            case .error:    return "E"
            }
        }
    }
}

extension Log {
    /// 주어진 메세지를 verbose 타입으로 출력
    ///
    /// - Parameter
    ///   - message:  출력할 메세지
    ///   - file:     파일명
    ///   - function: 함수명
    ///   - line:     라인
    static func v(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Log.Destination.console.write(.verbose, file, function, line, message())
    }

    /// 주어진 메세지를 debug 타입으로 출력
    ///
    /// - Parameter
    ///   - message:  출력할 메세지
    ///   - file:     파일명
    ///   - function: 함수명
    ///   - line:     라인
    static func d(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Log.Destination.console.write(.debug, file, function, line, message())
    }

    /// 주어진 메세지를 info 타입으로 출력
    ///
    /// - Parameter
    ///   - message:  출력할 메세지
    ///   - file:     파일명
    ///   - function: 함수명
    ///   - line:     라인
    static func i(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Log.Destination.console.write(.info, file, function, line, message())
    }

    /// 주어진 메세지를 warning 타입으로 출력
    ///
    /// - Parameter
    ///   - message:  출력할 메세지
    ///   - file:     파일명
    ///   - function: 함수명
    ///   - line:     라인
    static func w(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Log.Destination.console.write(.warning, file, function, line, message())
    }

    /// 주어진 메세지를 error 타입으로 출력
    ///
    /// - Parameter
    ///   - message:  출력할 메세지
    ///   - file:     파일명
    ///   - function: 함수명
    ///   - line:     라인
    static func e(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Log.Destination.console.write(.error, file, function, line, message())
    }
}


