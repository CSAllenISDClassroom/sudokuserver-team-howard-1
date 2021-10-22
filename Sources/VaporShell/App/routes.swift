import Vapor
import Foundation
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
    var currentGames : [Int] = []

    app.get { req in
        return "It works!"
    }
    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    ////////////////////////////////////////////////////////// creates a sudoku board and creates an id to associate with the board
    app.post("games") {req -> [String:String] in
        //let difficulty = String(req.parameters.get("difficulty")!)
        let difficulty : String? = req.query["difficulty"]

        if difficulty != "easy" && difficulty != "medium" && difficulty != "hard" && difficulty != "hell"{
            throw Abort(.badRequest, reason: "Difficulty is invalid")
        }
        
        let partialBoard = makeBoard(difficulty:difficulty!)
        let gameID = GameID.createID(runningGames:runningGames)
        currentGames.append(gameID)
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
            throw Abort(.badRequest, reason: "id is not a integer")
        }
        if !currentGames.contains(id){
            throw Abort(.badRequest, reason: "id is not in use")
        }

        //new
        func repeated(boardString: String) -> [Int]{
            var newCells = Dictionary<Int, Int>()
            var wrongCells : [Int] = []
            
            var newNumber = 0
            
            for x in 1 ... 81{
                var currentCellCheck = boardString[newNumber]
                while currentCellCheck == " " || currentCellCheck == "\n"{
                    newNumber += 1
                    currentCellCheck = boardString[newNumber]
                }
                
                if currentCellCheck == "-"{
                    newCells[x] = 0
                }else{
                    newCells[x] = Int(currentCellCheck)
                }
                newNumber += 1
            }
            for x in 1 ... 81{
                Cells["\(x)"] = newCells[x]
                //print(Cells["\(x)"])
                //print(newCells[x])
            }

            for x in 1 ... 81{
                //let hold = newCells[x]
                checkHor(x:x)
                checkVer(x:x)
                checkBox(x:x)
                if Cells["\(x)"] != newCells[x]{
                    wrongCells.append(x-1)
                    Cells["\(x)"] = newCells[x]
                }
            }
            print(wrongCells)
            return wrongCells
            
        }
        
        func incorrect(boardString: String, origin: String) -> [Int]{
            var originCells = Dictionary<Int, Int>()
            var newCells = Dictionary<Int, Int>()
            var wrongCells : [Int] = []
            
            var newNumber = 0
            var oldNumber = 0
            
            for x in 0 ... 80{
                var currentCellCheck = boardString[newNumber]
                var tcurrentCellCheck = origin[oldNumber]        
                while currentCellCheck == " " || currentCellCheck == "\n"{
                    newNumber += 1
                    currentCellCheck = boardString[newNumber]
                }
                while tcurrentCellCheck == " " || tcurrentCellCheck == "\n"{
                    oldNumber += 1
                    tcurrentCellCheck = origin[oldNumber]
                }
                
                if currentCellCheck == "-"{
                    newCells[x] = 0
                }else{
                    newCells[x] = Int(currentCellCheck)
                }
                originCells[x] = Int(tcurrentCellCheck)
                newNumber += 1
                oldNumber += 1

            }
            print(originCells)
            print(newCells)
            for x in 0 ... 80{
                if originCells[x] != newCells[x]{
                    wrongCells.append(x)
                }
            }
            return wrongCells
        }
        
        //end
        
        //let id = Int(req.parameters.get("id")!)!
        let partialBoard = runningGames[id]!
        //let response = partialBoard.boardString
        //encoder.outputFormatting = .prettyPrinted
        //let data = try encoder.encode(partialBoard.boardString)
        //let body = Response.Body(string: String(data:data, encoding: .utf8)!)
        //let response = Response(status: .created, body: body)

        let currentCellCheckWeGo = partialBoard.boardString

        var numTimes = 0
        var lineIndicator = 0
        //var takeNotes = 0
        
        var test0 : [Cell] = []
        var test1 : [Cell] = []
        var test2 : [Cell] = []
        var test3 : [Cell] = []
        var test4 : [Cell] = []
        var test5 : [Cell] = []
        var test6 : [Cell] = []
        var test7 : [Cell] = []
        var test8 : [Cell] = []
        for x in 0 ..< currentCellCheckWeGo.length{
            if currentCellCheckWeGo[x] != " " && currentCellCheckWeGo[x] != "\n" && currentCellCheckWeGo[x] != "n"{
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
                if currentCellCheckWeGo[x] != "-"{
                    value = Int(currentCellCheckWeGo[x])!
                }else{
                    value = nil
                }
                
                //Let's begin
                let position = Position(boxIndex:boxIndex, cellIndex:cellIndex)
                //let chris = try encoder.encode(position)
                //let john = Response.Body(string: String(data:chris, encoding: .utf8)!)
                let cell = Cell(position:position, value:value)
                //let theEpicInfo = try encoder.encode(cell)
                //let theEpicString = String(data:theEpicInfo, encoding:.utf8)!
                //test.append(cell)
                switch cell.position.boxIndex {
                case 0:
                    test0.append(cell)
                case 1:
                    test1.append(cell)
                case 2:
                    test2.append(cell)
                case 3:
                    test3.append(cell)
                case 4:
                    test4.append(cell)
                case 5:
                    test5.append(cell)
                case 6:
                    test6.append(cell)
                case 7:
                    test7.append(cell)
                case 8:
                    test8.append(cell)
                default:
                    fatalError("you've done did it now")
                
                }
                //Let's give up
                
                numTimes += 1
            }
        }

        func figureItOut(cellIdNumbers:[Int]) -> Board{
            let BoxZero = [0,1,2,9,10,11,18,19,20]
            let BoxOne = [3,4,5,12,13,14,21,22,23]
            let BoxTwo = [6,7,8,15,16,17,24,25,26]
            let BoxThree = [27,28,29,36,37,38,45,46,47]
            let BoxFour = [30,31,32,39,40,41,48,49,50]
            let BoxFive = [33,34,35,42,43,44,51,52,53]
            let BoxSix = [54,55,56,63,64,65,72,73,74]
            let BoxSeven = [57,58,59,66,67,68,75,76,77]
            let BoxEight = [60,61,62,69,70,71,78,79,80]

            var incorrectCells0 : [Cell] = []
            var incorrectCells1 : [Cell] = []
            var incorrectCells2 : [Cell] = []
            var incorrectCells3 : [Cell] = []
            var incorrectCells4 : [Cell] = []
            var incorrectCells5 : [Cell] = []
            var incorrectCells6 : [Cell] = []
            var incorrectCells7 : [Cell] = []
            var incorrectCells8 : [Cell] = []

            
            for x in 0 ..< cellIdNumbers.count{
                if BoxZero.contains(cellIdNumbers[x]){
                    var thisOne = 0
                    while BoxZero[thisOne] != cellIdNumbers[x]{
                        thisOne += 1
                    }
                    incorrectCells0.append(test0[thisOne])
                }
                if BoxOne.contains(cellIdNumbers[x]){
                    var thisOne = 0
                    while BoxOne[thisOne] != cellIdNumbers[x]{
                        thisOne += 1
                    }
                    incorrectCells1.append(test1[thisOne])
                }
                if BoxTwo.contains(cellIdNumbers[x]){
                    var thisOne = 0
                    while BoxTwo[thisOne] != cellIdNumbers[x]{
                        thisOne += 1
                    }
                    incorrectCells2.append(test2[thisOne])
                }
                if BoxThree.contains(cellIdNumbers[x]){
                    var thisOne = 0
                    while BoxThree[thisOne] != cellIdNumbers[x]{
                        thisOne += 1
                    }
                    incorrectCells3.append(test3[thisOne])
                }
                if BoxFour.contains(cellIdNumbers[x]){
                    var thisOne = 0
                    while BoxFour[thisOne] != cellIdNumbers[x]{
                        thisOne += 1
                    }
                    incorrectCells4.append(test4[thisOne])
                }
                if BoxFive.contains(cellIdNumbers[x]){
                    var thisOne = 0
                    while BoxFive[thisOne] != cellIdNumbers[x]{
                        thisOne += 1
                    }
                    incorrectCells5.append(test5[thisOne])
                }
                if BoxSix.contains(cellIdNumbers[x]){
                    var thisOne = 0
                    while BoxSix[thisOne] != cellIdNumbers[x]{
                        thisOne += 1
                    }
                    incorrectCells6.append(test6[thisOne])
                }
                if BoxSeven.contains(cellIdNumbers[x]){
                    var thisOne = 0
                    while BoxSeven[thisOne] != cellIdNumbers[x]{
                        thisOne += 1
                    }
                    incorrectCells7.append(test7[thisOne])
                }
                if BoxEight.contains(cellIdNumbers[x]){
                    var thisOne = 0
                    while BoxEight[thisOne] != cellIdNumbers[x]{
                        thisOne += 1
                    }
                    incorrectCells8.append(test8[thisOne])
                }
                
            }
            let incorrectBox0 = Box(cells:incorrectCells0)
            let incorrectBox1 = Box(cells:incorrectCells1)
            let incorrectBox2 = Box(cells:incorrectCells2)
            let incorrectBox3 = Box(cells:incorrectCells3)
            let incorrectBox4 = Box(cells:incorrectCells4)
            let incorrectBox5 = Box(cells:incorrectCells5)
            let incorrectBox6 = Box(cells:incorrectCells6)
            let incorrectBox7 = Box(cells:incorrectCells7)
            let incorrectBox8 = Box(cells:incorrectCells8)
            
            let notRight : [Box] = [incorrectBox0, incorrectBox1, incorrectBox2, incorrectBox3, incorrectBox4, incorrectBox5, incorrectBox6, incorrectBox7, incorrectBox8]

            return Board(board:notRight)
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
        let filter: String? = req.query["filter"]

        let yeahIKnowMrBen : [Box] = [Box0, Box1, Box2, Box3, Box4, Box5, Box6, Box7, Box8]
        //let nonoBaby = String(data:alrightBaby, encoding: .utf8)!
        let allCells = Board(board:yeahIKnowMrBen)
        let wrongs = incorrect(boardString:partialBoard.boardString, origin:partialBoard.origin)
        let repeatedCells = repeated(boardString:partialBoard.boardString)
        print(wrongs)
        if filter == "all"{
            return allCells
        }else if filter == "incorrect"{
            return figureItOut(cellIdNumbers: wrongs)
        }else if filter == "repeated"{
            return figureItOut(cellIdNumbers: repeatedCells)
        }else{
            throw Abort(.badRequest, reason: "Filter not valid")
        }
    }
    
    //return ["board" : returning]

    
    ///////////////////////////////////////////////// given specific board id box and cell allows you to change the value inside of the box
    app.put("games",":id","cells",":boxIndex",":cellIndex") { req -> String in
        guard let id = req.parameters.get("id", as: Int.self),
              let boxIndex = req.parameters.get("boxIndex", as: Int.self),
              let cellIndex = req.parameters.get("cellIndex", as: Int.self) else{
             throw Abort(.badRequest, reason: "temp.")
        }
        if (0 > boxIndex) || (boxIndex > 8){
            throw Abort(.badRequest, reason: "boxIndex out of range")
        }
        if (0 > cellIndex) || (cellIndex > 8){
            throw Abort(.badRequest, reason: "cellIndex out of range")
        }
          if !currentGames.contains(id){
            throw Abort(.badRequest, reason: "id is not in use")
        }

         
        
        //let id = Int(req.parameters.get("id")!)!
        //let boxIndex = Int(req.parameters.get("boxIndex")!)!
        //let cellIndex = Int(req.parameters.get("cellIndex")!)!
        let partialBoard = runningGames[id]!
        //let num = Int(req.body.string!)!
        
        struct CellValue: Decodable{
            let value: Int?
        }
        let cellValue = try req.content.decode(CellValue.self)

        guard cellValue.value == nil || (1 ... 9).contains(cellValue.value!) else {
            throw Abort(.badRequest, reason: "temp.")
        }
        
        
        runningGames[id] = sudokuBoard(boardString: alterCell(boardString: partialBoard.boardString, num: cellValue.value, boxIndex: boxIndex, cellIndex: cellIndex), origin: partialBoard.origin)

        return alterCell(boardString: partialBoard.boardString, num: cellValue.value, boxIndex: boxIndex, cellIndex: cellIndex)
        //return Response(status: .noContent)
    }
}
