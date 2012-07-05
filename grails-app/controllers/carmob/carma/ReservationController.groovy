package carmob.carma

import org.springframework.dao.DataIntegrityViolationException

/**
*  Dieser Controller verwaltet die Reservierungen
*
*
*/
class ReservationController {
    def authenticationService
    def asyncMailService
    String reservation_link = "http://carmadeploy.herokuapp.com/transfer/show/"
    int _taking_reservation_cost = 2 //Aendern um Kosten fuer Reservierungen anzupassen
    int _taked_reservation_value = 2   //Aendern um Punkte fuer das Holen einer abgegebenen Reservierung durch einen anderen User
    int submit_reservation = 4 //Aendern um Punkte fuer Abgeben von Reservierungen anzupassen
    
    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

    /**
    *  Nicht verwendet
    */
    def index() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
        } else {
            redirect action: 'list', params: params
        }
    }
    
    
    /**
    *  Nicht verwendet - Zeigt eigene Reservierungen
    */
    def list() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
       
        [reservationInstanceList: Reservation.findAllByProvider(authenticationService.getUserPrincipal()) , reservationInstanceTotal: Reservation.count()]
    }
    
    /**
    *  Generiert das Formular fuer Richtung und Datum beim abgeben eines Tickets
    */
    def select_date() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        if(params.direction) {
            params.direction=Direction.get(params.int("direction"))
        }
        if(params.date) {
            params.date = Date.parse("dd.MM.yyyy",params.date)
        }
        def reservationInstance = new Reservation(params)
        switch (request.method) {
            case 'GET':
            [reservationInstance: reservationInstance, directionList : Direction.list()]
            break
            case 'POST':
            if (!reservationInstance.validate(['date'])) {
                render view: 'select_date', model: [reservationInstance: reservationInstance, directionList : Direction.list()]
                return
            }
                
            redirect(action : 'create', params: [ date : reservationInstance.date.getTime(), direction:params.direction.id])
            break
        }
    }
    
    /**
    * Generiert das Formular fuer Verbindungen, Platz und Bestellnummer fuer Ticket abgeben
    * 
    */
    def create() {
    
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        if(params.transfer) {
            params.transfer=Transfer.get(params.int("transfer"))
        }
        if(params.direction) {
            params.direction=Direction.get(params.int("direction"))
        }
        if(!params.date) {
            redirect(action: 'select_date')
            return
        }
        params.date = new Date(params.long("date"))
        def reservationInstance = new Reservation(params)
        
       
        def transferList = createTransferList(reservationInstance,params.direction)
    
        [reservationInstance: reservationInstance, transferList: transferList, direction : params.direction]
          
    }
    
    def createTransferList(reservationInstance,direction) {
         def transferList_0_10 = Transfer.createCriteria().list() {
            and {
                eq("weekday",reservationInstance.date.getDay())
                eq("dirId",direction)
                lt("departureHours",10)
            }
            
            order("departureHours","asc")
            order("departureMinutes","asc")
             
        }
         def transferList_10_14 = Transfer.createCriteria().list() {
            and {
                eq("weekday",reservationInstance.date.getDay())
                eq("dirId",direction)
                ge("departureHours",10)
                lt("departureHours",14)
                
            }
            
            order("departureHours","asc")
            order("departureMinutes","asc")
             
        }
         def transferList_14_18 = Transfer.createCriteria().list() {
            and {
                eq("weekday",reservationInstance.date.getDay())
                eq("dirId",direction)
                 ge("departureHours",14)
                lt("departureHours",18)
            }
            
            order("departureHours","asc")
            order("departureMinutes","asc")
             
        }
         def transferList_18_24 = Transfer.createCriteria().list() {
            and {
                eq("weekday",reservationInstance.date.getDay())
                eq("dirId",direction)
                ge("departureHours",18)
                
            }
            
            order("departureHours","asc")
            order("departureMinutes","asc")
             
        }
        return [transferList_0_10,transferList_10_14,transferList_14_18,transferList_18_24]
        
    }
    
    
    /**
    * Erstellt eine Reservierung
    */
    def submit() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        if(params.transfer) {
            params.transfer=Transfer.get(params.int("transfer"))
        }
       
        def direction=Direction.get(params.int("direction"))
        params.remove("direction")
        params.date = new Date(params.long("date"))
        
        def reservationInstance = new Reservation(params)
         
        def transferList = createTransferList(reservationInstance,direction)
        reservationInstance.provider = authenticationService.getUserPrincipal() 
        reservationInstance.provider.carma = reservationInstance.provider.carma+submit_reservation
        
        if (!reservationInstance.save(flush: true)) {
            render view: 'create', model: [reservationInstance: reservationInstance, transferList: transferList, direction :direction]
            return
        }
        
        Date today = new Date();
        def history = new History(
            // User user
            user: authenticationService.getUserPrincipal(),

            // Date date
            date: today,

            // String type
            type: "abgegeben",
                    
            // Reservation reservation
            reservation: reservationInstance,
                    
            // Integer carmachange
            carmachange: "5",
                    
            // Integer carma
            carma: reservationInstance.provider.carma
        )
        if(!history.save()) {
            history.errors.allErrors.each {
                println it
            }
        }
        
        flash.message = "Ihre Reservierung wurde erfolgreich abgegeben! Sie haben dafür "+submit_reservation+" CARMA Punkte erhalten!"
        redirect action: 'show', id: reservationInstance.id
    }
    
    
    /**
    * Zeigt die erstellte Reservierungen an
    */
    def show() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        def reservationInstance = Reservation.get(params.id)
        if (!reservationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
            redirect action: 'list'
            return
        }
        
        [reservationInstance: reservationInstance]
    }

    /**
    * Nicht verwendet - Reservierungen editieren
    */ 
    def edit() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
        }
        switch (request.method) {
            case 'GET':
            def reservationInstance = Reservation.get(params.id)
            if (!reservationInstance) {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
                redirect action: 'list'
                return
            }

            [reservationInstance: reservationInstance]
            break
            case 'POST':
            def reservationInstance = Reservation.get(params.id)
            if (!reservationInstance) {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
                redirect action: 'list'
                return
            }

            if (params.version) {
                def version = params.version.toLong()
                if (reservationInstance.version > version) {
                    reservationInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
                        [message(code: 'reservation.label', default: 'Reservation')] as Object[],
	                          "Another user has updated this Reservation while you were editing")
                    render view: 'edit', model: [reservationInstance: reservationInstance]
                    return
                }
            }

            reservationInstance.properties = params

            if (!reservationInstance.save(flush: true)) {
                render view: 'edit', model: [reservationInstance: reservationInstance]
                return
            }

            flash.message = message(code: 'default.updated.message', args: [message(code: 'reservation.label', default: 'Reservation'), reservationInstance.id])
            redirect action: 'show', id: reservationInstance.id
            break
        }
    }
    /**
    * Nicht verwendet -- Reservierung loeschen
    */
    def delete() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        def reservationInstance = Reservation.get(params.id)
        if (!reservationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
            redirect action: 'list'
            return
        }

        try {
            reservationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
            redirect action: 'show', id: params.id
        }
    }
    
    /**
    *  Mit dieser Methode kann ein Nutzer eine Reservierung fuer sich beanspruchen
    */
    
    def get_reservation() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        if(params.id) {
            def reservationInstance = Reservation.get(params.id)
            def user = authenticationService.getUserPrincipal()
            
                if(reservationInstance.user== null && !user.hasReservationFor(reservationInstance.transfer)) {
                    if(user.carma >=_taking_reservation_cost){
                        user.carma=user.carma-_taking_reservation_cost
                     }
                    else{
                        user.carma=0
                    }
                    reservationInstance.user = user
                    reservationInstance.provider.carma = reservationInstance.provider.carma + _taked_reservation_value
                    reservationInstance.save(flush:true)
                    flash.message = "Reservierung erfolgreich geholt!"
                    
                    // Reservierung geholt
                    Date today = new Date();
                    def history = new History(
                        user: user,
                        date: today,
                        type: "geholt von " + reservationInstance.provider.login,
                        reservation: reservationInstance,
                        carmachange: "-" + _taking_reservation_cost,
                        carma: user.carma
                    )
                    if(!history.save()) {
                        history.errors.allErrors.each {
                            println it
                        }
                    }
        
                    // Reservierung übertragen
                    def history2 = new History(
                        user: reservationInstance.provider,
                        date: today,
                        type: "übertragen an " + user.login,
                        reservation: reservationInstance,
                        carmachange: _taking_reservation_cost,
                        carma: reservationInstance.provider.carma
                    )
                    if(!history2.save()) {
                        history2.errors.allErrors.each {
                            println it
                        }
                    }                
            }
            redirect(controller: "transfer", action: "show", id: reservationInstance.transfer.id)
        }
        
    }
    
    /**
    * Erlaubt dem Benutzer reservierungen zurück zugeben
    */ 
    def return_reservation() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        if(params.id) {
            def reservationInstance = Reservation.get(params.id)
            def user = authenticationService.getUserPrincipal()
            if(reservationInstance.user==user) {
                 reservationInstance.user = null
                 if(reservationInstance.provider.carma >=_taked_reservation_value){
                    reservationInstance.provider.carma = reservationInstance.provider.carma - _taked_reservation_value
                 }
                 else{
                     reservationInstance.provider.carma = 0
                 }
                reservationInstance.save(flush:true)
                flash.message = "Reservierung erfolgreich zurückgegeben!"
            }
            redirect(controller: "transfer", action: "show", id: reservationInstance.transfer.id)
        }
        
    }    
   
    /**
    * Erlaubt dem Benutzer E-Mail Benachrichtigung für eine Reservierung zu aktivieren
    */ 
    def observe_reservation() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        if(params.id) {
            def user =authenticationService.getUserPrincipal()
            def reservationInstance = Reservation.get(params.id)    
            def transferInstance = reservationInstance.transfer
            Date now = new Date()
            int carma_time
            if(transferInstance.weekday!=now.getDay()){
                carma_time=((transferInstance.departureHours+24)-(now.getHours()+((authenticationService.getUserPrincipal().carma)/5)+1))*60*60*1000
            }
            else{
                carma_time=(transferInstance.departureHours-(now.getHours()+((authenticationService.getUserPrincipal().carma)/5)+1))*60*60*1000
            }
             asyncMailService.sendMail{
                to    user.email
                subject "Deine Zugreservierung ist jetzt verfügbar";
                html '<body>Hallo ' +user.login +'<br/>Du kannst dir nun eine Reservierung unter folgendem link holen:<a href="'+reservation_link+transferInstance.id+'">'+reservation_link+transferInstance.id+'</a></body>';
                 // Additional asynchronous parameters (optional)
                beginDate new Date(System.currentTimeMillis()+carma_time)    // Starts after one minute, default current date               
                endDate new Date(System.currentTimeMillis()+carma_time+1200000)   // Must be sent in twenty minutes, default infinity
                maxAttemptsCount 3;   // Max 3 attempts to send, default 1
                attemptInterval 300000;    // Minimum five minutes between attempts, default 300000 ms
                delete true;    // Mark message for delete after sent
             }
            flash.message= "Du erhälst eine E-Mail sobald du die Reservierung holen kannst."
            redirect(controller: "transfer", action: "show", id: reservationInstance.transfer.id)
        }
    }
}
