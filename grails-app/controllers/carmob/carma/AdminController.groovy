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
    BahnProvider p = new BahnProvider(); 
    Date startdatum = new Date();
    def index() {
        // add cities
        City berlin = new City(name: "Berlin").save()
        City wolfsburg = new City(name: "Wolfsburg").save()
        City ingolstadt = new City(name: "Ingolstadt").save()
        
        // add directions
        Direction berlinWolfsburg = new Direction(from: berlin, to: wolfsburg).save()
        Direction wolfsburgBerlin = new Direction(from: wolfsburg, to: berlin).save()
        Direction berlinIngolstadt = new Direction(from: berlin, to: ingolstadt).save()
        Direction ingolstadtBerlin = new Direction(from: ingolstadt, to: berlin).save()
        
        LinkedList<Dir> dirList = new LinkedList();
        dirList.add(new Dir("Berlin Hbf", "Wolfsburg Hbf", berlinWolfsburg));
        dirList.add(new Dir("Wolfsburg Hbf", "Berlin Hbf", wolfsburgBerlin));
        dirList.add(new Dir("Berlin Hbf", "Ingolstadt Hbf", berlinIngolstadt));
        dirList.add(new Dir("Ingolstadt Hbf", "Berlin Hbf", ingolstadtBerlin));

        //add transfer           
        Date enddatum = new Date();
        enddatum.setTime(enddatum.getTime()+ (86400000*7));
        
        boolean activeBoolean = true;
        for (Dir dir : dirList) {
            System.out.print("****************newQuery*******************");

            startdatum = new Date();
            while (startdatum.getTime() < enddatum.getTime()){
                System.out.print("**************newTime**********************" + startdatum);
                QueryConnectionsResult result = getQuery(dir.from, dir.to);

                for (Connection item : result.connections) {
                    System.out.print("*******************newConnection*******************");

                    GetConnectionDetailsResult result2 = p.getConnectionDetails(item.link);
                    
                    if(result2.connection.getFirstDepartureTime()<=enddatum){
                        if(result2.connection.parts.size()==1){
                       
                            
                            def iceString = result2.connection.getFirstTrip().line.label;
                            iceString = iceString.substring(1);
                            def departureHours = result2.connection.getFirstDepartureTime().getHours() 
                            def departureMinutes = result2.connection.getFirstDepartureTime().getMinutes()
                
                            def arrivalHours = result2.connection.getLastArrivalTime().getHours() 
                            def arrivalMinutes = result2.connection.getLastArrivalTime().getMinutes();
                            def weekday =  result2.connection.getFirstDepartureTime().getDay();

                            // TESTAUSGABEN
                            // String direction
                            System.out.print("Von: " + dir.from);
                            System.out.print("Nach: " + dir.to);
                
                            // String ice
                            System.out.print("ice: " + iceString);

                            // String departure
                            System.out.print("Abfahrtszeit: " + departureHours + ":" + departureMinutes);

                            // String arrival
                            System.out.print("Ankunftszeit: " + arrivalHours + ":" + arrivalMinutes);

                            // String weekday;
                            System.out.print("Wochentag: " + weekday);

                            def transfer = new Transfer(
                                // String ice
                                ice: iceString,

                                // Direction dirId;
                                dirId: dir.dir,

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
                            //startdatum = result2.connection.getFirstDepartureTime();
                            
                        }
                    }
                    startdatum.setTime(result2.connection.getFirstDepartureTime().getTime()+360000);
                }
            }
        } 
    }
    
    public QueryConnectionsResult getQuery(String from, String to){
        final QueryConnectionsResult result = p.queryConnections(
            new Location(LocationType.ANY, 0, null, from), 
            null, 
            new Location(LocationType.ANY, 0, null, to), 
            startdatum, 
            true, 
            1, 
            "IRSUTBFC", 
            de.schildbach.pte.NetworkProvider.WalkSpeed.NORMAL, 
            de.schildbach.pte.NetworkProvider.Accessibility.NEUTRAL);
        return result;
    }
}

private class Dir {
    private String from;
    private String to;
    private Direction dir;
    
    public Dir(String f, String t, Direction d){
        from = f;
        to = t;
        dir = d;
    }
    
    public String getfrom(){
        return from;
    }
    
    public String getto(){
        return to;
    }
    
    public Direction getdir(){
        return dir;
    }
}
