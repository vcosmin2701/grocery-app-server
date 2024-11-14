import Foundation
import grocery_app_shared_dto
import Vapor

extension LoginResponseDTO: @retroactive AsyncResponseEncodable {}
extension LoginResponseDTO: @retroactive AsyncRequestDecodable {}
extension LoginResponseDTO: @retroactive ResponseEncodable {}
extension LoginResponseDTO: @retroactive RequestDecodable {}
extension LoginResponseDTO: @retroactive Content {
    
}
