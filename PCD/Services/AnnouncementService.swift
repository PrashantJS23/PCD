//
//  AnnouncementService.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

import Combine
import Foundation

protocol AnnouncementServiceProtocol {
    func fetchAnnouncements() -> AnyPublisher<[Announcement], NetworkError>
    func downloadFile(urlString: String) -> AnyPublisher<URL, NetworkError>
}

final class AnnouncementService: AnnouncementServiceProtocol {
    private let network: NetworkManaging

    init(network: NetworkManaging) {
        self.network = network
    }

    convenience init() {
        self.init(network: NetworkProvider.network(forMockFile: MockConstants.announcements))
    }

    func fetchAnnouncements() -> AnyPublisher<[Announcement], NetworkError> {
        let url = APIConstants.fullURL(for: APIConstants.Endpoints.announcements)
        return network.get(urlString: url)
    }
    
    func downloadFile(urlString: String) -> AnyPublisher<URL, NetworkError> {
        return network.downloadFile(from: urlString)
    }
}
