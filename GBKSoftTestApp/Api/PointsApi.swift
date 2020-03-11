//
//  PointsApi.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 01.03.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import Firebase
import CodableFirebase

final class PointsApi {
    
    func getPoints(completion: @escaping (([Point], String?) -> Void)) {
        let ref = Database.database().reference()
        ref.observe(.value, with: {snapshot in
            if snapshot.childrenCount > 0 {
                ref.child("points").observe(.value, with: { snap in
                    guard let value = snap.value else { return }
                    guard let dict = value as? [String: Any] else { return }
                    let valuesArray = dict.map({ $0.value })
                    do {
                        let points = try FirebaseDecoder()
                            .decode([Point].self, from: valuesArray)
                        completion(points, nil)
                    } catch let error {
                        completion([Point](), error.localizedDescription)
                    }
                })
            } else {
                completion([Point](), nil)
            }
            
        })
    }
    
    func setNewPoint(point: Point) {
        let data = try! FirebaseEncoder().encode(point)
        Database.database().reference().child("points").childByAutoId().setValue(data)
    }
    
    func deletePoint(point: Point, completion: @escaping ((String?) -> Void)) {
        let ref = Database.database().reference()
        ref.child("points").queryOrdered(byChild: "name").queryEqual(toValue: "\(point.name)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let forumPosts = snapshot.value as? [String: [String: AnyObject]] {
                for (key, _) in forumPosts  {
                    FirebaseDatabase.Database.database().reference(withPath: "points").child(key).removeValue()
                }
            }
        })
    }
}
