import Vapor

//let encoder = JSONEncoder()

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

struct Position : Content{
    var boxIndex : Int
    var cellIndex: Int
}

struct Cell : Content{
    var position : Position
    var value : Int?
}

struct Box : Content{
    var cells : [Cell]
}

struct Board : Content{
    var board : [Box]
}


extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

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
        //let difficulty = String(req.parameters.get("difficulty")!)
        let difficulty: String? = req.query["difficulty"]
        let partialBoard = sudokuBoard(boardString: makeBoard(difficulty:difficulty!))
        let gameID = GameID.createID(runningGames:runningGames)
        runningGames[gameID] = partialBoard
        return ["id": String(gameID)]
    }

    ////////////////////////////////////////////////////////// displays the board on the screen givent the boardid number
    app.get("games",":id","cells") { req -> [String:String] in
        guard let id = req.parameters.get("id", as: Int.self) else {
            return ["Error" : "id invalid"]
        }
        //let id = Int(req.parameters.get("id")!)!
        let partialBoard = runningGames[id]!
        //let response = partialBoard.boardString
        //encoder.outputFormatting = .prettyPrinted
        //let data = try encoder.encode(partialBoard.boardString)
        //let body = Response.Body(string: String(data:data, encoding: .utf8)!)
        //let response = Response(status: .created, body: body)

        let returning = partialBoard.boardString
        
        return ["board" : returning]
    }

    //testing out printing in the way Mr.Ben wants because he is the ultimate ruller and dictates how and why things are made
    app.get("games",":id","cells", "json") { req -> Board in
        guard let id = req.parameters.get("id", as: Int.self) else {
            //return "id is invalid"
            throw Abort(.badRequest, reason: "temp.")
        }
        //let id = Int(req.parameters.get("id")!)!
        let partialBoard = runningGames[id]!
        //let response = partialBoard.boardString
        //encoder.outputFormatting = .prettyPrinted
        //let data = try encoder.encode(partialBoard.boardString)
        //let body = Response.Body(string: String(data:data, encoding: .utf8)!)
        //let response = Response(status: .created, body: body)

        let hereWeGo = partialBoard.boardString

        var numTimes = 0
        var lineIndicator = 0
        //var takeNotes = 0
        var iDontKnow : [String] = []
        var test0 : [Cell] = []
        var test1 : [Cell] = []
        var test2 : [Cell] = []
        var test3 : [Cell] = []
        var test4 : [Cell] = []
        var test5 : [Cell] = []
        var test6 : [Cell] = []
        var test7 : [Cell] = []
        var test8 : [Cell] = []
        for x in 0 ..< hereWeGo.length{
            if hereWeGo[x] != " " && hereWeGo[x] != "\n" && hereWeGo[x] != "n"{
                if numTimes == 9{
                    lineIndicator += 1
                    numTimes = 0
                    //takeNotes = x
                }
                var cellIndex = 0
                var boxIndex = 0
                if numTimes <= 2{
                    cellIndex = numTimes + (3*lineIndicator) - (9*Int(lineIndicator/3))
                }else if numTimes <= 5{
                    cellIndex = (numTimes-3) + (3*lineIndicator) - (9*Int(lineIndicator/3))
                }else{
                    cellIndex = (numTimes-6) + (3*lineIndicator) - (9*Int(lineIndicator/3))
                }
                
                if numTimes <= 2{
                    boxIndex = 0
                }else if numTimes <= 5{
                    boxIndex = 1
                }else{
                    boxIndex = 2
                }
                if lineIndicator >= 3{
                    boxIndex += 3
                }
                if lineIndicator >= 6{
                    boxIndex += 3
                }
                
                var value : Int? = 0
                if hereWeGo[x] != "-"{
                    value = Int(hereWeGo[x])!
                }else{
                    value = nil
                }
                iDontKnow.append("boxIndex: \(boxIndex)")
                iDontKnow.append("cellIndex: \(cellIndex)")
                iDontKnow.append("value: \(value)")

                //Let's begin
                let yippee = Position(boxIndex:boxIndex, cellIndex:cellIndex)
                //let chris = try encoder.encode(yippee)
                //let john = Response.Body(string: String(data:chris, encoding: .utf8)!)
                let yahaa = Cell(position:yippee, value:value)
                //let theEpicInfo = try encoder.encode(yahaa)
                //let theEpicString = String(data:theEpicInfo, encoding:.utf8)!
                //test.append(yahaa)
                switch yahaa.position.boxIndex {
                case 0:
                    test0.append(yahaa)
                case 1:
                    test1.append(yahaa)
                case 2:
                    test2.append(yahaa)
                case 3:
                    test3.append(yahaa)
                case 4:
                    test4.append(yahaa)
                case 5:
                    test5.append(yahaa)
                case 6:
                    test6.append(yahaa)
                case 7:
                    test7.append(yahaa)
                case 8:
                    test8.append(yahaa)
                default:
                    fatalError("you've done did it now")
                
                }
                //Let's give up
                
                numTimes += 1
            }
        }
        let Box0 = Box(cells:test0)
        let Box1 = Box(cells:test1)
        let Box2 = Box(cells:test2)
        let Box3 = Box(cells:test3)
        let Box4 = Box(cells:test4)
        let Box5 = Box(cells:test5)
        let Box6 = Box(cells:test6)
        let Box7 = Box(cells:test7)
        let Box8 = Box(cells:test8)
        //let alrightBaby = try encoder.encode(cruse)
        let yeahIKnowMrBen : [Box] = [Box0, Box1, Box2, Box3, Box4, Box5, Box6, Box7, Box8]
        //let nonoBaby = String(data:alrightBaby, encoding: .utf8)!
        let go = Board(board:yeahIKnowMrBen)
        print(iDontKnow)
        return go
    }
    
    //return ["board" : returning]

    
    ///////////////////////////////////////////////// given specific board id box and cell allows you to change the value inside of the box
    app.put("games",":id","cells",":boxIndex",":cellIndex") { req -> String in
        guard let id = req.parameters.get("id", as: Int.self),
              let boxIndex = req.parameters.get("boxIndex", as: Int.self),
              let cellIndex = req.parameters.get("cellIndex", as: Int.self) else{
            return("bad")
        }
        
        
        //let id = Int(req.parameters.get("id")!)!
        //let boxIndex = Int(req.parameters.get("boxIndex")!)!
        //let cellIndex = Int(req.parameters.get("cellIndex")!)!
        let partialBoard = runningGames[id]!
        let num = Int(req.body.string!)!
        
        runningGames[id] = sudokuBoard(boardString: alterCell(boardString: partialBoard.boardString, num: num, boxIndex: boxIndex, cellIndex: cellIndex))

        return alterCell(boardString: partialBoard.boardString, num: num, boxIndex: boxIndex, cellIndex: cellIndex)
    }
}
