package carmob.carma

class Transfer {
    String ice;
    Direction dirId;
    Integer departureMinutes;
    Integer departureHours;
    Integer arrivalMinutes;
    Integer arrivalHours;
    Integer weekday;
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
    static mapping = {
        sort:"departureHours,departureMinutes asc" 
    }

    def numReservations() {
        return Reservation.countByTransfer(this)
        
    }
    def numOpenReservations() {
         return Reservation.countByTransferAndUserIsNull(this)
    }
    
    def arrival() {
        def date=new Date() 
        date.setHours(arrivalHours)
        date.setMinutes(arrivalMinutes)
        date.format("H:mm")
    }
     def departure() {
        def date=new Date() 
        date.setHours(departureHours)
        date.setMinutes(departureMinutes)
        date.format("H:mm")
    }
}
