package carmob.carma

import de.schildbach.pte.BahnProvider;
import de.schildbach.pte.NetworkProvider.Accessibility;
import de.schildbach.pte.NetworkProvider.WalkSpeed;
import de.schildbach.pte.dto.Connection;
import de.schildbach.pte.dto.Location;
import de.schildbach.pte.dto.LocationType;
import de.schildbach.pte.dto.QueryConnectionsResult;
import de.schildbach.pte.dto.GetConnectionDetailsResult;

class AdminController {
    
    def index() {
        // add cities
        City berlin = new City(name: "Berlin").save()
        City wolfsburg = new City(name: "Wolfsburg").save()
        
        // add directions
        Direction berlinWolfsburg = new Direction(from: berlin, to: wolfsburg).save()
        Direction wolfsburgBerlin = new Direction(from: wolfsburg, to: berlin).save()
        
        //add transfer
        BahnProvider p = new BahnProvider();
        Date startdatum = new Date();
        Date enddatum = new Date();
        enddatum.setTime(enddatum.getTime()+ (86400000*7));
        String iceString;
        String departureString;
        String arrivalString;
        String weekdayString;
        boolean activeBoolean = true;
                
        
        while (startdatum.getTime() < enddatum.getTime()){
            final QueryConnectionsResult result = p.queryConnections(
                new Location(LocationType.ANY, 0, null, "Berlin Hbf"), 
                null, 
                new Location(LocationType.ANY, 0, null, "Wolfburg Hbf"), 
                startdatum, 
                true, 
                4, 
                "IRSUTBFC", 
                de.schildbach.pte.NetworkProvider.WalkSpeed.NORMAL, 
                de.schildbach.pte.NetworkProvider.Accessibility.NEUTRAL);
            
            //Testausgaben!
            for (Connection item : result.connections) {
                GetConnectionDetailsResult result2 = p.getConnectionDetails(item.link);

                // String ice
                System.out.print("ice: " + result2.connection.getFirstTrip().line);

                // String departure
                System.out.print("; Abfahrtszeit: " + result2.connection.getFirstDepartureTime().getHours() + ":" + result2.connection.getFirstDepartureTime().getMinutes());

                // String arrival
                System.out.print("; Ankunftszeit: " + result2.connection.getLastArrivalTime().getHours() + ":" + result2.connection.getLastArrivalTime().getMinutes());

                // String weekday;
                System.out.print("; Wochentag: " + result2.connection.getFirstDepartureTime().getDay());

                // boolean active;
                System.out.println("; Aktiv: true");

                startdatum = result2.connection.getFirstDepartureTime();
            }
            
            
            for (Connection item : result.connections) {
                GetConnectionDetailsResult result2 = p.getConnectionDetails(item.link);
                
                iceString = result2.connection.getFirstTrip().line;
                departureString = result2.connection.getFirstDepartureTime().getHours() + ":" + result2.connection.getFirstDepartureTime().getMinutes();
                arrivalString = result2.connection.getLastArrivalTime().getHours() + ":" + result2.connection.getLastArrivalTime().getMinutes();
                weekdayString =  result2.connection.getFirstDepartureTime().getDay();
                
                new Transfer(
                    // String ice
                    ice: iceString,

                    // Direction dirId;
                    dirId: berlinWolfsburg,

                    // String departure
                    departure: departureString,
                
                    // String arrival
                    arrival: arrivalString,
                    
                    // String weekday;
                    weekday: weekdayString,
                    
                    // boolean active;
                    active: activeBoolean
                ).save()
                startdatum = result2.connection.getFirstDepartureTime();
            }
        } 
    }
}
