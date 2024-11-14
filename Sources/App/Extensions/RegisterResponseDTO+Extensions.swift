import Foundation
import grocery_app_shared_dto
import Vapor

extension RegisterResponseDTO: @retroactive AsyncResponseEncodable {}
extension RegisterResponseDTO: @retroactive AsyncRequestDecodable {}
extension RegisterResponseDTO: @retroactive ResponseEncodable {}
extension RegisterResponseDTO: @retroactive RequestDecodable {}
extension RegisterResponseDTO: @retroactive Content {
    
}


