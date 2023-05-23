import Foundation

public struct Swime {
  /// File data
  let data: Data

  ///  A static method to get the `MimeType` that matches the given file data
  ///
  ///  - returns: Optional<MimeType>
  public static func mimeType(data: Data) -> MimeType? {
    mimeType(swime: Swime(data: data))
  }

  ///  A static method to get the `MimeType` that matches the given bytes
  ///
  ///  - returns: Optional<MimeType>
  public static func mimeType(bytes: [UInt8]) -> MimeType? {
    mimeType(swime: Swime(bytes: bytes))
  }

  ///  Get the `MimeType` that matches the given `Swime` instance
  ///
  ///  - returns: Optional<MimeType>
  public static func mimeType(swime: Swime) -> MimeType? {
    let bytes = swime.readBytes(count: min(swime.data.count, 262))

    for mime in MimeType.all {
      if mime.matches(bytes: bytes, swime: swime) {
        return mime
      }
    }

    return nil
  }

  public static func mimeType(url: URL) -> MimeType? {
    guard let inputStream = InputStream(url: url) else {
      return nil
    }

    inputStream.open()
    defer {
      inputStream.close()
    }

    var data = Data()
    let bufferSize = 262
    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
    defer {
      buffer.deallocate()
    }
    while inputStream.hasBytesAvailable {
      let count = inputStream.read(buffer, maxLength: bufferSize)
      if count == 0 {
        break
      }
      if count == -1 {
        // Convert function to throwing and throw here
        return nil
      }
      data.append(buffer, count: count)
      if data.count >= bufferSize {
        // We only want the first 262 bytes
        break
      }
    }

    return mimeType(data: data)
  }

  public init(data: Data) {
    self.data = data
  }

  public init(bytes: [UInt8]) {
    self.init(data: Data(bytes))
  }

  ///  Read bytes from file data
  ///
  ///  - parameter count: Number of bytes to be read
  ///
  ///  - returns: Bytes represented with `[UInt8]`
  internal func readBytes(count: Int) -> [UInt8] {
    var bytes = [UInt8](repeating: 0, count: count)

    data.copyBytes(to: &bytes, count: count)

    return bytes
  }
}

@objc public class SwimeObjC: NSObject {
  @objc
  public class func mimeType(url: URL) -> MimeTypeObjC? {
    guard let mimeType = Swime.mimeType(url: url) else {
      return nil
    }
    return MimeTypeObjC(mimeType: mimeType)
  }
}

@objc public class MimeTypeObjC: NSObject {
  @objc
  public var mime: String {
    mimeType.mime
  }

  @objc
  public var ext: String {
    mimeType.ext
  }

  private let mimeType: MimeType

  public init(mimeType: MimeType) {
    self.mimeType = mimeType
  }
}
