//
//  ErrorMiddleware.swift
//  VaporBackend
//
//  Created by ROBIN HUMNE on 09/06/25.
//

import Vapor

struct ErrorMiddleware: AsyncMiddleware {
    func respond(
        to request: Request,
        chainingTo next: AsyncResponder
    ) async throws -> Response {
        do {
            return try await next.respond(to: request)
        } catch {
            return handleError(error, for: request)
        }
    }
    
    private func handleError(_ error: Error, for request: Request) -> Response {
        let status: HTTPResponseStatus
        let message: String
        
        if let abort = error as? AbortError {
            status = abort.status
            message = abort.reason
        } else {
            status = .internalServerError
            message = "Something went wrong."
        }
        
        request.logger.report(error: error)
        
        let response = Response(status: status)
        do {
            try response.content.encode([
                "error": true,
                "message": message
            ])
        } catch {
            response.body = .init(string: "Oops: \(error)")
            response.headers.replaceOrAdd(name: .contentType, value: "text/plain")
        }
        
        return response
    }
}
