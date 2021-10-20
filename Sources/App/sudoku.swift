import Foundation
import Vapor

//used to hold the number associated with each cell of the sudoku board
var Cells = Dictionary<String, Int>()

func checkHor(x : Int){
    var checking = 1
    var plus = false
    let currentCheck = Cells["\(x)"]
    //checking = x
    plus = false
    for y in 1 ... 8{
        if y == 1{
            if x == 1 || ((x-1) % 9) == 0 {
                checking = x + 1
                plus = true
            }else if x <= 9 {
                checking = 1
                plus = true
            }else if x <= 18{
                checking = 10
                plus = true
            }else if x <= 27{
                checking = 19
                plus = true
            }else if x <= 36{
                checking = 28
                plus = true
            }else if x <= 45{
                checking = 37
                plus = true
            }else if x <= 54{
                checking = 46
                plus = true
            }else if x <= 63{
                checking = 55
                plus = true
            }else if x <= 72{
                checking = 64
                plus = true
            }else if x <= 81{
                checking = 73
                plus = true
            }
        }
        if currentCheck == Cells["\(checking)"] && Cells["\(x)"] != 0{
            
            Cells["\(x)"] = 0
            plus = false
        }
        if checking + 1 == x{
            checking += 2
        }else if plus{
            checking += 1
         }
    }
}

func checkVer(x : Int){
    var checking = 1
    var plus = false
    let currentCheck = Cells["\(x)"]
    plus = true
    for y in 1 ... 8{
        if y == 1{
            if x <= 9{
                checking = x + 9
                plus = true
            }else if (x - 1) % 9 == 0 {
                checking = 1
                plus = true
            }else if (x - 2) % 9 == 0 {
                checking = 2
                plus = true
            }else if (x-3)%9 == 0{
                checking = 3
                plus = true
            }else if (x-4)%9 == 0{
                checking = 4
                plus = true
            }else if (x-5)%9 == 0{
                checking = 5
                plus = true
            }else if (x-6)%9 == 0{
                checking = 6
                plus = true
            }else if (x-7)%9 == 0{
                checking = 7
                plus = true
            }else if (x-8)%9 == 0{
                checking = 8
                plus = true
            }else if (x-9)%9 == 0{
                checking = 9
                plus = true
            }
        }
        if currentCheck == Cells["\(checking)"] && Cells["\(x)"] != 0{
            
            Cells["\(x)"] = 0
            plus = false
        }
        if checking + 9 == x{
            checking += 18
        }else if plus{
            checking += 9
        }
    }
}

//creates an array of 9 numbers for each inidividual box 

let BoxOne = [1,2,3,10,11,12,19,20,21]
let BoxTwo = [4,5,6,13,14,15,22,23,24]
let BoxThree = [7,8,9,16,17,18,25,26,27]
let BoxFour = [28,29,30,37,38,39,46,47,48]
let BoxFive = [31,32,33,40,41,42,49,50,51]
let BoxSix = [34,35,36,43,44,45,52,53,54]
let BoxSeven = [55,56,57,64,65,66,73,74,75]
let BoxEight = [58,59,60,67,68,69,76,77,78]
let BoxNine = [61,62,63,70,71,72,79,80,81]

//checking contents of each individual box

func checkBox(x : Int){
    let currentCheck = Cells["\(x)"]
    if BoxOne.contains(x){
        for y in 0 ..< BoxOne.count{
            if BoxOne[y] != x{
                if Cells["\(BoxOne[y])"] == currentCheck && Cells["\(BoxOne[y])"] != 0{
                    Cells["\(x)"] = 0
                }
            }
        }
    }
    
    if BoxTwo.contains(x){
        for y in 0 ..< BoxTwo.count{
            if BoxTwo[y] != x{
                if Cells["\(BoxTwo[y])"] == currentCheck && Cells["\(BoxOne[y])"] != 0{
                    Cells["\(x)"] = 0
                }
            }
        }
    }
    
    if BoxThree.contains(x){
        for y in 0 ..< BoxThree.count{
            if BoxThree[y] != x{
                if Cells["\(BoxThree[y])"] == currentCheck{
                    Cells["\(x)"] = 0
                }
            }
        }
    }
    
    if BoxFour.contains(x){
        for y in 0 ..< BoxFour.count{
            if BoxFour[y] != x{
                if Cells["\(BoxFour[y])"] == currentCheck{
                    Cells["\(x)"] = 0
                }
            }
        }
    }
    
    if BoxFive.contains(x){
        for y in 0 ..< BoxFive.count{
            if BoxFive[y] != x{
                if Cells["\(BoxFive[y])"] == currentCheck{
                    Cells["\(x)"] = 0
                }
            }
        }
    }
    
    if BoxSix.contains(x){
        for y in 0 ..< BoxSix.count{
            if BoxSix[y] != x{
                if Cells["\(BoxSix[y])"] == currentCheck{
                    Cells["\(x)"] = 0
                }
            }
        }
    }
    
    if BoxSeven.contains(x){
        for y in 0 ..< BoxSeven.count{
            if BoxSeven[y] != x{
                if Cells["\(BoxSeven[y])"] == currentCheck{
                    Cells["\(x)"] = 0
                }
            }
        }
    }
    
    if BoxEight.contains(x){
        for y in 0 ..< BoxEight.count{
            if BoxEight[y] != x{
                if Cells["\(BoxEight[y])"] == currentCheck{
                    Cells["\(x)"] = 0
                }
            }
        }
    }
    
    if BoxNine.contains(x){
        for y in 0 ..< BoxNine.count{
            if BoxNine[y] != x{
                if Cells["\(BoxNine[y])"] == currentCheck && Cells["\(BoxNine[y])"] != 0{
                    Cells["\(x)"] = 0
                }
            }
        }
    }
}

func boardCheck(){
    var theNumbers = [0]
    for _ in 1...81{
        var x : Int
        repeat{
            x = Int.random(in:1...81)
        }while theNumbers.contains(x)
        theNumbers.append(x)
        checkHor(x:x)
        checkVer(x:x)
        checkBox(x:x)
    }
}

//prints completed board
func printOut() -> String{
    var printingBoard : String = ""
    for x in 1 ... 81{
        switch Cells["\(x)"]{
        case 0:
              printingBoard += "-  "
        default:
            printingBoard += "\(Cells["\(x)"]!)  "
        }
        if x % 9 == 0{
            printingBoard += "\n"
        }
    }
    return printingBoard
}

func solvedCheck() -> Bool{
    var cellNumberCheck = 1
    var unfilled = 0
    var numberCheck = [1,2,3,4,5,6,7,8,9]
    var possibleNumbers : [Int] = []
    var fail = 0
    //var done = false

    repeat{
        
        if Cells["\(cellNumberCheck)"] == 0{
            unfilled = cellNumberCheck
        }else{
            cellNumberCheck += 1
        }
        if cellNumberCheck > 81{
            return true
        }

    }while unfilled == 0

    for _ in 0...8{
        
        let y = Int.random(in:0 ..< numberCheck.count)
        Cells["\(unfilled)"] = numberCheck[y]
        checkHor(x:unfilled)
        checkVer(x:unfilled)
        checkBox(x:unfilled)
        if Cells["\(unfilled)"] == 0{
            numberCheck.remove(at:y)
        }else{
            possibleNumbers.append(numberCheck[y])
            numberCheck.remove(at:y)
            
        }
    }

    repeat{
        
        if possibleNumbers.count == 0{
            Cells["\(unfilled)"] = 0
            return false
        }
        let y = Int.random(in:0 ..< possibleNumbers.count)
        Cells["\(unfilled)"] = possibleNumbers[y]
        
        let ohBoy = solvedCheck()
        if ohBoy{
            return true
        }else{
            possibleNumbers.remove(at:y)
        }
        fail += 1
    }while fail < 80000000
    fatalError("damn")
    //return false
}

func difficultySetting(difficulty:String){
    var clearedCells : [Int] = []
    switch difficulty{
    case "easy":
        for _ in 1 ... 12{
            var x = 0
            repeat{
                x = Int.random(in:1...81)
            }while clearedCells.contains(x)
            clearedCells.append(x)
            Cells["\(x)"] = 0
        }
    case "medium":
        for _ in 1 ... 32{
            var x = 0
            repeat{
                x = Int.random(in:1...81)
            }while clearedCells.contains(x)
            clearedCells.append(x)
            Cells["\(x)"] = 0
        }
    case "hard":
        for _ in 1 ... 55{
            var x = 0
            repeat{
                x = Int.random(in:1...81)
            }while clearedCells.contains(x)
            clearedCells.append(x)
            Cells["\(x)"] = 0
        }
    case "hell":
        for _ in 1 ... 70{
            var x = 0
            repeat{
                x = Int.random(in:1...81)
            }while clearedCells.contains(x)
            clearedCells.append(x)
            Cells["\(x)"] = 0
        }
    default:
        fatalError("Not correct difficulty")
    }
}

func makeBoard(difficulty:String) -> String{
    for x in 1 ... 81{
        Cells["\(x)"] = 0
    }
    if solvedCheck(){
        difficultySetting(difficulty:difficulty)
    }
        return "\(printOut())"
}


///////////////////////////////////////////////////// This func gives each box a specific index from 0...8 and gives each cell a id 0...8 based of the box called. I used a seperator becuase I could not find the original board before making it a string. Will change once we cleanup code. 
func alterCell(boardString: String, num: Int, boxIndex: Int, cellIndex: Int) -> String {
    var rows = boardString.split(separator: "\n").map{String($0)}
    for offset in 0..<rows.count {
        let row = rows[offset]
        let boxOffset = (offset / 3) * 3
        let cellOffset = (offset * 3) % 9
        var cells = row.split(separator: " ").map{String($0)}
        for i in 0..<cells.count {
            //let cell = cells[i]
            let cellNum = (i % 3) + cellOffset
            let boxNum = (i / 3) + boxOffset
            if (boxNum == boxIndex && cellNum == cellIndex) {
                cells[i] = String(num)
            }
        }
        rows[offset] = cells.joined(separator: " ")   
    }
    return rows.joined(separator: "\n")
}

struct sudokuBoard {
    var boardString : String
}
