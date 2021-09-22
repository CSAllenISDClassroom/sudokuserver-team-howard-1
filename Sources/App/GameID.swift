
class GameID{
    init(){

    }
    public static func createID(runningGames: runningGames) -> Int{
        return Int.random(in: 1 ... 10000)
    }
}
