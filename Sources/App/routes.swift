import Vapor

let encoder = JSONEncoder()

func routes(_ app: Application) throws {
    
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    app.post("games") { req -> Response in
        
        let newBoard = try req.content.decode(SudokuBoard.self)
        newBoard.id = newBoard.boardID
        newBoard.boardID += 1
        newBoard.makeTheThing()
        let yippee = newBoard.printOut()
        let hope = THEBoard(id: newBoard.id, board: yippee)
        // return ["Board ID" : String(newBoard.id)]
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(hope.id)
        let body = Response.Body(string: String(data: data, encoding: .utf8)!)
        let response = Response(status: .ok,body: body)
        return response
        
    }
}
