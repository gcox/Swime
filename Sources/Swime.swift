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
      data.append(buffer, count: count)
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
