package carmob.carma

class AdminController {
    
    def index() {
        // add cities
        City berlin = new City(name: "Berlin").save()
        City wolfsburg = new City(name: "Wolfsburg").save()
        
        // add directions
        new Direction(from: berlin, to: wolfsburg).save()
        new Direction(from: wolfsburg, to: berlin).save()
    }
}
