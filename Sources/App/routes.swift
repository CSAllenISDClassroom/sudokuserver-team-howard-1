import Vapor
<<<<<<< HEAD
var runningGames = [Int: sudokuBoard] ()



///////////////////
/*func create(req: Request) throws -> HTTPStatus {
    let background = try req.content.decode(Background.self)
    print(background)
    return HTTPStatus.ok
} */      
//////////////////
=======

>>>>>>> ae99399c98ac9031c5e48bc2d18fd32e3e2ee80d
func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
<<<<<<< HEAD
    
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


=======

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
}
>>>>>>> ae99399c98ac9031c5e48bc2d18fd32e3e2ee80d
