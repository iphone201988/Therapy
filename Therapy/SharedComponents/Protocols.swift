
protocol ServicesEvents {
    func resumeShorts()
    func selectedPlaybackSpeed(value: Double)
    func selectedPixel(value: Int?)
    func handlePIP(isEnable: Bool)
    func dismissVC()
}

extension ServicesEvents {
    func resumeShorts() {}
    func selectedPlaybackSpeed(value: Double) {}
    func selectedPixel(value: Int?) {}
    func handlePIP(isEnable: Bool) {}
    func dismissVC() {}
}
