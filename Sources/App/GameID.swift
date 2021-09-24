//////////////////////////////////////////////////creates the game IDs which will be associated with the boards
class GameID{
    init(){
    }
    public static func createID(runningGames: [Int:sudokuBoard]) -> Int{
        
        return Int.random(in: 1 ... 10000)
    }
}
