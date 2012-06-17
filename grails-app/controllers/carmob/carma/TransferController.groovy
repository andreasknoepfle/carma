package carmob.carma

import org.springframework.dao.DataIntegrityViolationException
import grails.orm.PagedResultList
class TransferController {

    def authenticationService
    
    
    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

    def index() {
        redirect action: 'list', params: params
    }

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
        def transferList = Transfer.createCriteria().list(max: params.max, offset: params.offset) {
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
        if(transferList.getTotalCount()<10) {
             
            transferListTomorrow = Transfer.createCriteria().list() {
                maxResults(10-transferList.size())
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

    def select_direction() {
          
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
        }
        [directionList : Direction.list()]
    }
    
    def show() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
        }
        def transferInstance = Transfer.get(params.id)
        if (!transferInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'transfer.label', default: 'Transfer'), params.id])
            redirect action: 'list'
            return
        }
        
        [transferInstance: transferInstance,reservationsList: Reservation.findAllByTransfer(transferInstance),myReservation: Reservation.findByTransferAndUser(transferInstance,authenticationService.getUserPrincipal())]
    }

    
}