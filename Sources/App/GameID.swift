//////////////////////////////////////////////////creates the game IDs which will be associated with the boards
class GameID{
    init(){
    }
    //////////Generates a random number utilized to represent the GameID
    public static func createID(runningGames: [Int:sudokuBoard]) -> Int{
        return Int.random(in: 1 ... 10000)
    }
}
