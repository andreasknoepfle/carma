package carmob.carma

/**
* Modelliert eine Zug-Verbindung 
*/
class Transfer {
    /**
    * Linier
    */
    String ice;
     /**
    * Richtung
    */
    Direction dirId;
     /**
    * Abfahrt Uhrzeit Minute
    */
    Integer departureMinutes;
      /**
    * Abfahrt Uhrzeit Stunde
    */
    Integer departureHours;
      /**
    * Ankunft Uhrzeit Minute
    */
    Integer arrivalMinutes;
      /**
    * Ankunft Uhrzeit Stunde
    */
    Integer arrivalHours;
    /**
    * Wochentag So==0
    */
    Integer weekday;
    /**
    * Nicht mehr verwendet
    */
    boolean active;
    static hasMany = [reservations: Reservation]
    static constraints = {
        ice blank:false
        departureMinutes min:0,max:59
        departureHours min:0,max:23
        arrivalMinutes min:0,max:59
        arrivalHours min:0,max:23
        weekday min:0,max:6
    }
    /**
    * Sortierung
    */
    static mapping = {
        sort:"departureHours,departureMinutes asc" 
    }

     /**
    * Gesamtanzahl Reservierungen dieser Verbindung
    */
    def numReservations() {
        def reservations= Reservation.createCriteria().count() {
               
                and {
                    eq("transfer",this)
                   
                     between("date",new Date().clearTime(),new Date().clearTime().plus(2))
                }
            
             
            }
        return reservations
        
    }
    /**
    * Anzahl offnener Reservierungen dieser Verbindung
    */
    def numOpenReservations() {
        def reservations= Reservation.createCriteria().count() {
               
                and {
                    eq("transfer",this)
                    isNull("user")
                    between("date",new Date().clearTime(),new Date().clearTime().plus(2))
                }
            
             
            }
        return reservations
    }
    /**
    * Uhrzeit Formatierung Ankunft
    */
    def arrival() {
        def date=new Date() 
        date.setHours(arrivalHours)
        date.setMinutes(arrivalMinutes)
        date.format("H:mm")
    }
     /**
    * Uhrzeit Formatierung Abfahrt
    */
     def departure() {
        def date=new Date() 
        date.setHours(departureHours)
        date.setMinutes(departureMinutes)
        date.format("H:mm")
    }
}
