import Foundation

public struct Swime {
  /// File data
  let data: Data

  public init(data: Data) {
    self.data = data
  }

  ///  Get the `MimeType` that matches the file data
  ///
  ///  - returns: Optional<MimeType>
  public func mimeType() -> MimeType? {
    let bytes = readBytes(count: 262)

    for mime in MimeType.all {
      if mime.matches(bytes: bytes, swime: self) {
        return mime
      }
    }

    return nil
  }

  ///  Read bytes from file data
  ///
  ///  - parameter count: Number of bytes to be read
  ///
  ///  - returns: Bytes represented with `[UInt8]`
  public func readBytes(count: Int) -> [UInt8] {
    var bytes = [UInt8](repeating: 0, count: count)

    data.copyBytes(to: &bytes, count: count)

    return bytes
  }

  ///  Check if file data matches with the given `MimeTypeExtension`
  ///
  ///  - parameter ext: `MimeTypeExtension`
  ///
  ///  - returns: `Bool`
  public func typeIs(_ ext: MimeTypeExtension) -> Bool {
    return mimeType()?.extEnum == Optional.some(ext)
  }
}
