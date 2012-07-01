package carmob.carma

/**
* Achtung - Dieser Controller wird nur zu Administrativen Zwecken während der Programmierung verwendet !
*/
class HistoryController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [historyInstanceList: History.list(params), historyInstanceTotal: History.count()]
    }

    def create = {
        def historyInstance = new History()
        historyInstance.properties = params
        return [historyInstance: historyInstance]
    }

    def save = {
        def historyInstance = new History(params)
        if (!historyInstance.hasErrors() && historyInstance.save()) {
            flash.message = "history.created"
            flash.args = [historyInstance.id]
            flash.defaultMessage = "History ${historyInstance.id} created"
            redirect(action: "show", id: historyInstance.id)
        }
        else {
            render(view: "create", model: [historyInstance: historyInstance])
        }
    }

    def show = {
        def historyInstance = History.get(params.id)
        if (!historyInstance) {
            flash.message = "history.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "History not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [historyInstance: historyInstance]
        }
    }

    def edit = {
        def historyInstance = History.get(params.id)
        if (!historyInstance) {
            flash.message = "history.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "History not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [historyInstance: historyInstance]
        }
    }

    def update = {
        def historyInstance = History.get(params.id)
        if (historyInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (historyInstance.version > version) {
                    
                    historyInstance.errors.rejectValue("version", "history.optimistic.locking.failure", "Another user has updated this History while you were editing")
                    render(view: "edit", model: [historyInstance: historyInstance])
                    return
                }
            }
            historyInstance.properties = params
            if (!historyInstance.hasErrors() && historyInstance.save()) {
                flash.message = "history.updated"
                flash.args = [params.id]
                flash.defaultMessage = "History ${params.id} updated"
                redirect(action: "show", id: historyInstance.id)
            }
            else {
                render(view: "edit", model: [historyInstance: historyInstance])
            }
        }
        else {
            flash.message = "history.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "History not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def historyInstance = History.get(params.id)
        if (historyInstance) {
            try {
                historyInstance.delete()
                flash.message = "history.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "History ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "history.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "History ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "history.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "History not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
