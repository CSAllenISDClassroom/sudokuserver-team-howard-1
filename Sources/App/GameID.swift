//////////////////////////////////////////////////creates the game IDs which will be associated with the boards
class GameID{
    init(){
    }
    public static func createID(runningGames: [Int:sudokuBoard]) -> Int{
<<<<<<< HEAD

=======
        
>>>>>>> 3bb192a0e27a69e4486037d67250c4c5f46846dd
        return Int.random(in: 1 ... 10000)
    }
}
