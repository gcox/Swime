import Foundation

func loadFileData(path: String) -> Data {
  try! Data(contentsOf: loadFileURL(path: path))
}

func loadFileURL(path: String) -> URL {
  URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent(path)
}
