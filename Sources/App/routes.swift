import Vapor




///////////////////
/*func create(req: Request) throws -> HTTPStatus {
    let background = try req.content.decode(Background.self)
    print(background)
    return HTTPStatus.ok
} */      
//////////////////

func routes(_ app: Application) throws {
    var runningGames = [Int: sudokuBoard] ()
    
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
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
        let response = partialBoard.boardString
        return response
    }
    app.put("games",":id","cells",":boxIndex",":cellIndex") { req -> String in
        let id = Int(req.parameters.get("id")!)!
        let boxIndex = Int(req.parameters.get("boxIndex")!)!
        let cellIndex = Int(req.parameters.get("cellIndex")!)!
        let partialBoard = runningGames[id]!
        let num = Int(req.body.string!)!
        //let response = partialBoard.alterCell(boxIndex: )
        runningGames[id] = sudokuBoard(boardString: alterCell(boardString: partialBoard.boardString, num: num, boxIndex: boxIndex, cellIndex: cellIndex))
        return alterCell(boardString: partialBoard.boardString, num: num, boxIndex: boxIndex, cellIndex: cellIndex)
    }     
}


