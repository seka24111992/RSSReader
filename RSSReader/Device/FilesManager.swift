//
//  FilesManager.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import MobileCoreServices


open class FilesManager: NSObject {
    
    // MARK: - Mime Types
    
    public enum MimeTypes: String {
        case MP4Audio = "audio/mp4"
    }
    
    // MARK: - Singleton
    
    public static let shared = FilesManager()
    
    private var manager: Foundation.FileManager {
        return Foundation.FileManager.default
    }
    
    // MARK: - Constructor
    
    private override init() {
        super.init()
    }
    
    public func tempFileURL(withName name: String) -> URL {
        return URL(fileURLWithPath: name, isDirectory: false, relativeTo: URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true))
    }
    
    public func documentURL(withPath path: String) -> URL? {
        do {
            let documentsFolderURL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return documentsFolderURL.appendingPathComponent(path)
        }
        catch {
            return nil
        }
    }
    
    func mimeTypeForURL(url: URL) -> String {
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    public func documentURL(withName name: String) -> URL? {
        do {
            let documentsFolderURL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return URL(fileURLWithPath: name, isDirectory: false, relativeTo: documentsFolderURL)
        }
        catch {
            return nil
        }
    }
    
    public func exists(fileAt url: URL) -> Bool {
        return manager.fileExists(atPath: url.path)
    }
    
    public func sizeOfFile(url: URL) -> UInt64 {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: url.path)
            if let fileSize = fileAttributes[FileAttributeKey.size]  {
                return (fileSize as! NSNumber).uint64Value
            }
        } catch {
        }
        return 0
    }
    
    func sizeOfFolder(url: URL) -> Int64? {
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: url.path)
            var folderSize: Int64 = 0
            for content in contents {
                do {
                    let fullContentPath = url.path + "/" + content
                    let fileAttributes = try FileManager.default.attributesOfItem(atPath: fullContentPath)
                    folderSize += fileAttributes[FileAttributeKey.size] as? Int64 ?? 0
                } catch _ {
                    continue
                }
            }
            return folderSize
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func copyFiles(pathFromBundle : String, pathDestDocs: String) {
        let fileManagerIs = FileManager.default
        do {
            let filelist = try fileManagerIs.contentsOfDirectory(atPath: pathFromBundle)
            try? fileManagerIs.copyItem(atPath: pathFromBundle, toPath: pathDestDocs)
            
            for filename in filelist {
                try? fileManagerIs.copyItem(atPath: "\(pathFromBundle)/\(filename)", toPath: "\(pathDestDocs)/\(filename)")
            }
        } catch {
            print("\nError\n")
        }
    }
    
    @discardableResult
    public func createDirectories(at url: URL) -> Bool {
        do {
            var directoryURL = url
            if !directoryURL.hasDirectoryPath && !directoryURL.pathComponents.isEmpty {
                directoryURL.deleteLastPathComponent()
            }
            if !exists(fileAt: directoryURL) {
                try manager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            }
            return true
        }
        catch {
            return false
        }
    }
    
    @discardableResult
    public func replace(from url: URL, to destinationURL: URL) -> Bool {
        if !destinationURL.hasDirectoryPath {
            delete(at: destinationURL)
        }
        return copy(from: url, to: destinationURL)
    }
    
    @discardableResult
    public func copy(from url: URL, to destinationURL: URL) -> Bool {
        do {
            createDirectories(at: destinationURL)
            try manager.copyItem(at: url, to: destinationURL)
            return true
        }
        catch {
            return false
        }
    }
    
    @discardableResult
    public func delete(at url: URL) -> Bool {
        do {
            if exists(fileAt: url) {
                try manager.removeItem(at: url)
            }
            return true
        }
        catch {
            return false
        }
    }
}

