import Vapor

///////////////////
/*func create(req: Request) throws -> HTTPStatus {
    let background = try req.content.decode(Background.self)
    print(background)
    return HTTPStatus.ok
    } */      

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
    
    ////////////////////////////////////////////////////////// creates a sudoku board and creates an id to associate with the board
    app.post("games") {req -> [String:String] in
        let partialBoard = sudokuBoard(boardString: makeBoard())
        let gameID = GameID.createID(runningGames:runningGames)
        runningGames[gameID] = partialBoard        
        return ["id": String(gameID)]        
    }

    ////////////////////////////////////////////////////////// displays the board on the screen givent the boardid number
    app.get("games",":id","cells") { req -> String in
        guard let id = req.parameters.get("id", as: Int.self) else {
            return "id is invalid"
            //  throw Abort(.badRequest)
        }
        // let id = Int(req.parameters.get("id")!)!
        let partialBoard = runningGames[id]!
        let response = partialBoard.boardString

        return response
    }
    
    ///////////////////////////////////////////////// given specific board id box and cell allows you to change the value inside of the box
    app.put("games",":id","cells",":boxIndex",":cellIndex") { req -> String in
        guard let id = req.parameters.get("id", as: Int.self),
              let boxIndex = req.parameters.get("boxIndex", as: Int.self),
              let cellIndex = req.parameters.get("cellIndex", as: Int.self) else {
            //throw Abort(.badRequest)
            return "either id is inccorrect or boxIndex or cellIndex is out of range"
        }
        // let id = Int(req.parameters.get("id")!)!
        // let boxIndex = Int(req.parameters.get("boxIndex")!)!
        // let cellIndex = Int(req.parameters.get("cellIndex")!)!
         let partialBoard = runningGames[id]!
         let num = Int(req.body.string!)!
         runningGames[id] = sudokuBoard(boardString: alterCell(boardString: partialBoard.boardString, num: num, boxIndex: boxIndex, cellIndex: cellIndex))
         return alterCell(boardString: partialBoard.boardString, num: num, boxIndex: boxIndex, cellIndex: cellIndex)
    }     

}


