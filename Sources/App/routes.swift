import Vapor

struct Background : Content {
    let Action: String
    let Payload: String
    let Response: String
    let StatusCode: String
}
///////////////////
func create(req: Request) throws -> HTTPStatus {
    let background = try req.content.decode(Background.self)
    print(background)
    return HTTPStatus.ok
}       
//////////////////
func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    app.get("games",":id","cells") { req -> String in
        return "haha ur so smart"
    }
    app.post("games") { req -> String in
        return "test" 
        
    }
    app.put("games",":id","cells",":boxIndex",":cellIndex") { req -> String in
        return "test"
    } 

    
}



/*
POST /games
  * Action: Creates a new game and associated board
  * Payload: None
  * Response: Id uniquely identifying a game
  * Status code: 201 Created
GET /games/<id>/cells
              * Action: None
              * Payload: None
              * Response: cells
              * Status code: 200 OK
PUT /games/<id>/cells/<boxIndex>/<cellIndex>
* Action: Place specified value at in game at boxIndex, cellIndex
* Payload: value (null for removing value)
 Response: Nothing
 Status: 204 No Content
                                                                                   */
 
