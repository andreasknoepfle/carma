import carmob.carma.Transfer
import carmob.carma.City
import carmob.carma.Direction

class BootStrap {

    def init = { /*servletContext ->
        def csv = new File("grails-app/conf/bahn.csv")
        
        def Transfer =
        csv.splitEachLine(';') { fields -> new Transfer(
                ice: fields[0],
                dirId: fields[1],
                departure: fields[2],
                arrival: fields[3],
                weekday: fields[4],
                active: fields[5]
            ).save()
        }*/
    }
    
    def destroy = {
    }
}
