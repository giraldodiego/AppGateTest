struct AppGate {
    func createUser(_ user: User) {
        UserManager().createUser(user)
    }
    
    func validateUser(_ user: User, completion: @escaping (Bool) -> Void) {
        guard let coordinates = LocationManager().getLocation() else {
            completion(false)
            return
        }
        
        NetworkManager().getDate(latitude: coordinates.latitude, longitude: coordinates.longitude) { (date) in
            guard let date = date else {
                completion(false)
                return
            }
            completion(UserManager().validateUser(user: user, date: date.date))
        }
    }
    
    func getValidations(_ username: String) -> [UserValidation]? {
        return DataManager().getValidations(username)
    }
}
