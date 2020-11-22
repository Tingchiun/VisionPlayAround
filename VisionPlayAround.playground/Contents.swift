import UIKit
import Vision

var imageLabel: [String] = []


classifyTheImage(imageNamed: "DSCF2172.jpeg")?.forEach {
    print("\($0.identifier) \($0.confidence)")
}

detectHuman(imageNamed: "HumanTestImage1.jpg")?.forEach {
    print("Find human within boundingBox: \(String(describing: $0.boundingBox))")
}

func classifyTheImage(imageNamed: String) -> [VNClassificationObservation]? {
    guard let image = UIImage(named: imageNamed)?.cgImage else {
        print("Can't get image")
        return nil
    }
    let handler = VNImageRequestHandler(cgImage: image, options: [:])
    let request = VNClassifyImageRequest()
    try? handler.perform([request])
    let observations = request.results as? [VNClassificationObservation]
    return observations?.filter { $0.confidence > 0.5 }
}

func detectHuman(imageNamed: String) -> [VNDetectedObjectObservation]? {
    guard let image = UIImage(named: imageNamed)?.cgImage else {
        print("Can't get image")
        return nil
    }
    let request = VNDetectHumanRectanglesRequest()
    let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])

    try? requestHandler.perform([request])
    return request.results as? [VNDetectedObjectObservation]
}


