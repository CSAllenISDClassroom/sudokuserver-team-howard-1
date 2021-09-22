import Vapor
var runningGames = [Int: sudokuBoard] ()



///////////////////
/*func create(req: Request) throws -> HTTPStatus {
    let background = try req.content.decode(Background.self)
    print(background)
    return HTTPStatus.ok
} */      
//////////////////
func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    app.post("games") {req -> [String:String] in
        let partialBoard = sudokuBoard(boardString: makeBoard())
        let gameID = GameID.createID(runningGames:runningGames)
        runningGames[gameID] = partialBoard
        
        return ["id": String(gameID)]
        
        }
    
    app.get("games",":id","cells") { req -> String in
        let id = Int(req.parameters.get("id")!)!
        let partialBoard = runningGames[id]!
        let response = partialBoard()
        return response
    }
    app.put("games",":id","cells",":boxIndex",":cellIndex") { req -> String in
        return "test"
    } 

    
}


