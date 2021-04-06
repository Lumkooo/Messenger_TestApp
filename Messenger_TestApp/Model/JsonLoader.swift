//
//  JsonLoader.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/6/21.
//

import Foundation

final class JsonLoader {
    static func loadJSON(completion: @escaping ([Chat]) -> Void,
                         errorCompletion: @escaping ((String) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first {
                let pathWithFilename = documentDirectory.appendingPathComponent("Data.json")
                guard let data = try? Data(contentsOf: pathWithFilename) else {
                    let emptyChats: [Chat] = []
                    DispatchQueue.main.async {
                        completion(emptyChats)
                    }
                    return
                }
                if let parsedResult = try? JSONDecoder().decode(ChatResponse.self,
                                                                from: data) {
                    let chats = parsedResult.chats
                    DispatchQueue.main.async {
                        completion(chats)
                    }
                } else {
                    DispatchQueue.main.async {
                        errorCompletion("Произошла непредвиденная ошибка")
                    }
                }
            }
        }
    }
    
    static func saveJSON(chats: [Chat]) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                    in: .userDomainMask).first {
                    let pathWithFilename = documentDirectory.appendingPathComponent("Data.json")
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let chatResponse = ChatResponse(chats: chats)
                    let JsonData = try encoder.encode(chatResponse)
                    try JsonData.write(to: pathWithFilename)
                }
            } catch {
                assertionFailure("Error occured...")
            }
        }
    }
}

