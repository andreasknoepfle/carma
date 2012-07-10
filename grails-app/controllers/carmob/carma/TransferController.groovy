package carmob.carma

import org.springframework.dao.DataIntegrityViolationException
import grails.orm.PagedResultList

/**
* Zeigt verfuegbare Verbindungen und deren Reservierungen an ("Ticket holen")
*/
class TransferController {
Date now = new Date()
    def authenticationService
    
    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

    def index() {
        redirect action: 'list', params: params
    }

    /**
    * Listet Verbindungen einer bestimmten Richtung auf
    */
    def list() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        if (!params.direction) {
            redirect(controller: "transfer",action : "select_direction")
            return
        } 
        def direction=Direction.get(params.int('direction'))        
        Date now = new Date()
        params.max = params.max ? params.int('max') : 10
        params.offset = params.offset ? params.int('offset') :0 
        def transferListTomorrow = []
        def transferList = Transfer.createCriteria().list(max:params.max, offset:params.offset) {
            and {
                eq("dirId",direction)
                eq("weekday",now.getDay())
                or {
                    gt("departureHours",now.getHours()) 
                    and {
                        eq("departureHours",now.getHours())
                        gt("departureMinutes",now.getMinutes())
                    }
                }
            }
            
            order("departureHours","asc")
            order("departureMinutes","asc")
             
        }
        if(transferList.size()<params.max) {
             
            transferListTomorrow = Transfer.createCriteria().list() {
                maxResults(params.max-transferList.size())
                and {
                    eq("dirId",direction)
                    eq("weekday",now.getDay()+1)
                    or {
                        gt("departureHours",0) 
                        and {
                            eq("departureHours",0)
                            gt("departureMinutes",0)
                        }
                    }
                }
            
                order("departureHours","asc")
                order("departureMinutes","asc")
             
            }
            transferList.addAll transferListTomorrow 
        }
         
        
        [transferList : transferList, direction: direction,transferListTomorrow:transferListTomorrow]
    }

    /**
    * Auswahl der Richtung verwendet
    */ 
    def select_direction() {
          
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        [directionList : Direction.list()]
    }
    
    /**
    * Anzeigen einer Zugverbindung und den darin enthaltenen Reservierungen 
    */
    def show() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        def transferInstance = Transfer.get(params.id)
        if (!transferInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'transfer.label', default: 'Transfer'), params.id])
            redirect action: 'list'
            return
        }
        Date now =new Date()
        int carma_hours =now.getHours()+((authenticationService.getUserPrincipal().carma)/5)+1      
         int carma_day= now.getDay()  
         def remaining_time =new Date()
         if(transferInstance.weekday != carma_day){
             remaining_time.setHours(transferInstance.departureHours-(carma_hours-24))
             remaining_time.setMinutes(59-now.getMinutes())
         }
         else{
             if(transferInstance.departeHours>carma_hours){
                remaining_time.setHours(transferInstance.departureHours-(carma_hours))
                remaining_time.setMinutes(59-now.getMinutes())
             }
         }
         def reservations= Reservation.createCriteria().list() {
               
                and {
                    eq("transfer",transferInstance)
                    between("date",now.clearTime(),now.clearTime().plus(2))
                    
                }
            
             
            }
            def myreservation = Reservation.createCriteria().list {
                 and {
                    eq("transfer",transferInstance)
                    eq("user",authenticationService.getUserPrincipal())
                    between("date",now.clearTime(),now.clearTime().plus(2))
                    
                }
               
            }
        [transferInstance: transferInstance,reservationsList: reservations,myReservation:myreservation[0] ,carma_hours:carma_hours,carma_day:carma_day, remaining_time:remaining_time ]
    }
    
   

    
}
