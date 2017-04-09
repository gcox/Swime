# 🗂 Swime
Swift check MIME type based on magic bytes. Swime detects MIME type of a `Data`, ported from [sindresorhus/file-type](https://github.com/sindresorhus/file-type)

[![Build Status](https://travis-ci.org/sendyhalim/Swime.svg?branch=master)](https://travis-ci.org/sendyhalim/Swime)

## Installation
### Swift Package Manager
```swift
import PackageDescription

let package = Package(
  name: "MyApp",
  dependencies: [
    .Package(url: "https://github.com/sendyhalim/Swime", majorVersion: 1)
  ]
)
```

## Usage

Read data manually
```swift
import Swime

let projectDir = FileManager.default.currentDirectoryPath
let path = "/path/to/some-file.jpg"
let url = URL(fileURLWithPath: path, isDirectory: false)
let data = try! Data(contentsOf: url)
let swime = Swime(data: data)

swime.mimeType()! // MimeType(mime: "image/jpeg", ext: "jpg", extEnum: .jpg)
swime.typeIs(.jpg) == true

switch swime.mimeType()!.extEnum {
  case .jpg:
    ....
  case .png:
    ....
  case .wmv:
    ....

  case ....
}
```

Pass bytes to it
```swift
import Swime

let bytes: [UInt8] = [255, 216, 255]
let swime = Swime(bytes: bytes)

swime.mimeType()! // MimeType(mime: "image/jpeg", ext: "jpg", extEnum: .jpg)
```

## MimeTypeExtension
Here are the list of available `MimeTypeExtension`s, you can access it directly or from `swime.mimeType()!.extEnum`.

```swift
public enum MimeTypeExtension {
  case amr
  case ar
  case avi
  case bmp
  case bz2
  case cab
  case cr2
  case crx
  case deb
  case dmg
  case eot
  case epub
  case exe
  case flac
  case flif
  case flv
  case gif
  case gz
  case ico
  case jpg
  case jxr
  case lz
  case m4a
  case m4v
  case mid
  case mkv
  case mov
  case mp3
  case mp4
  case mpg
  case msi
  case mxf
  case nes
  case ogg
  case opus
  case otf
  case pdf
  case png
  case ps
  case psd
  case rar
  case rpm
  case rtf
  case sevenZ // 7z, Swift does not let us define enum that starts with a digit
  case sqlite
  case swf
  case tar
  case tif
  case ttf
  case wav
  case webm
  case webp
  case wmv
  case woff
  case woff2
  case xpi
  case xz
  case z
  case zip
}
```

## Testing
```
make test
```
