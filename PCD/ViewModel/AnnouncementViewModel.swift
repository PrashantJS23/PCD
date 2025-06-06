//
//  AnnouncementViewModel.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

import Combine
import Foundation

class AnnouncementViewModel: ObservableObject {
    @Published var announcements: [Announcement] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isDownloading = false
    @Published var downloadSuccess: Bool? = nil
    
    private let service: AnnouncementServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: AnnouncementServiceProtocol = AnnouncementService()) {
        self.service = service
    }
    
    func loadAnnouncement() {
        isLoading = true
        errorMessage = nil
        
        service.fetchAnnouncements()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] data in
                self?.announcements = data
            }
            .store(in: &cancellables)
    }
    
    func downloadFile(urlString: String) {
        isDownloading = true
        downloadSuccess = nil

        service.downloadFile(urlString: urlString)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isDownloading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Download failed: \(error)")
                    self?.downloadSuccess = false
                }
            }, receiveValue: { [weak self] fileURL in
                print("File downloaded to: \(fileURL)")
                self?.downloadSuccess = true
            })
            .store(in: &cancellables)
    }
}
