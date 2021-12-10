//
//  User.swift
//  MapppppPPPp
//
//  Created by Преподаватель on 10.12.2021.
//

import Foundation


class User{
    
    let cords = [[55.789198, 37.543618],[55.761139, 37.591684], [55.467636, 37.551671], [55.693327, 37.562158], [55.729766, 37.756479], [55.733060, 37.714936], [55.734609, 37.663781], [55.774494, 37.520616], [55.774494, 37.520616], [55.764623, 37.689187]]
    
    
    func getUser() -> [UserModel]?{
        let semaphore = DispatchSemaphore (value: 0)
        var users: [UserModel]?
        
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/users")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            users = try? JSONDecoder().decode([UserModel].self, from: data)
            for i in 0..<users!.count{
                users![i].address.geo.lat = String(self.cords[i][0])
                users![i].address.geo.lng = String(self.cords[i][1])
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return users
    }
    
}
