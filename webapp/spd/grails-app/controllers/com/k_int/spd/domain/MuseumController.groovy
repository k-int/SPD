package com.k_int.spd.domain

class MuseumController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [museumInstanceList: Museum.list(params), museumInstanceTotal: Museum.count()]
    }
	
	def search = {
		def results = Museum.createCriteria().list
		{
			and 
			{
				if(params.name) 	{ eq("name", params.name) }
				if(params.oldSpdId)	{ eq("oldSpdId", params.long('oldSpdId')) }
				if(params.region)	{ eq("region.id", params.long('region')) }
			}
		}
		[regionList: Region.list(), museumInstanceList: results, museumInstanceTotal: Museum.count()]	
	}

    def create = {
        def museumInstance = new Museum()
        museumInstance.properties = params
        return [museumInstance: museumInstance]
    }

    def save = {
        def museumInstance = new Museum(params)
        if (museumInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'museum.label', default: 'Museum'), museumInstance.id])}"
            redirect(action: "show", id: museumInstance.id)
        }
        else {
            render(view: "create", model: [museumInstance: museumInstance])
        }
    }

    def show = {
        def museumInstance = Museum.get(params.id)
        if (!museumInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'museum.label', default: 'Museum'), params.id])}"
            redirect(action: "list")
        }
        else {
            [museumInstance: museumInstance]
        }
    }

    def edit = {
        def museumInstance = Museum.get(params.id)
        if (!museumInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'museum.label', default: 'Museum'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [museumInstance: museumInstance]
        }
    }

    def update = {
        def museumInstance = Museum.get(params.id)
        if (museumInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (museumInstance.version > version) {
                    
                    museumInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'museum.label', default: 'Museum')] as Object[], "Another user has updated this Museum while you were editing")
                    render(view: "edit", model: [museumInstance: museumInstance])
                    return
                }
            }
            museumInstance.properties = params
            if (!museumInstance.hasErrors() && museumInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'museum.label', default: 'Museum'), museumInstance.id])}"
                redirect(action: "show", id: museumInstance.id)
            }
            else {
                render(view: "edit", model: [museumInstance: museumInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'museum.label', default: 'Museum'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def museumInstance = Museum.get(params.id)
        if (museumInstance) {
            try {
                museumInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'museum.label', default: 'Museum'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'museum.label', default: 'Museum'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'museum.label', default: 'Museum'), params.id])}"
            redirect(action: "list")
        }
    }
}
