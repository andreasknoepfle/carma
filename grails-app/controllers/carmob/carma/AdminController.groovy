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
                System.out.print("ice: " + result2.connection.getFirstTrip().line.label);

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
                
                def iceString = result2.connection.getFirstTrip().line.label;
                def departureHours = result2.connection.getFirstDepartureTime().getHours() 
                def departureMinutes = result2.connection.getFirstDepartureTime().getMinutes()
                
                def arrivalHours = result2.connection.getLastArrivalTime().getHours() 
                def arrivalMinutes = result2.connection.getLastArrivalTime().getMinutes();
                def weekday =  result2.connection.getFirstDepartureTime().getDay();
                
                def transfer = new Transfer(
                    // String ice
                    ice: iceString,

                    // Direction dirId;
                    dirId: berlinWolfsburg,

                    // departure
                    departureHours: departureHours,
                    departureMinutes:departureMinutes,
                    
                    // arrival
                    arrivalHours: arrivalHours,
                    arrivalMinutes: arrivalMinutes,
                    
                    // weekday;
                    weekday: weekday,
                    
                    // boolean active;
                    active: activeBoolean
                )
                if(!transfer.save()) {
                    transfer.errors.allErrors.each {
                    println it
                    }
                }
                startdatum = result2.connection.getFirstDepartureTime();
            }
        } 
    }
}
