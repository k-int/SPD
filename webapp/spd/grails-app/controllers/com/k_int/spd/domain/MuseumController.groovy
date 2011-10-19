package com.k_int.spd.domain

import grails.converters.*

class MuseumController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "search", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [museumInstanceList: Museum.list(params), museumInstanceTotal: Museum.count()]
    }
	
	def search = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def results = Museum.createCriteria().list(max: params.max, offset: params.offset)
		{
			and 
			{
				if(params.name) 	{ ilike("name", "%" + params.name + "%") }
				if(params.oldSpdId)	{ eq("oldSpdId", params.long('oldSpdId')) }
				if(params.region)	{ eq("region.id", params.long('region')) }
				if(params.sort && params.order) { order(params.sort, params.order)}
			}
		}
		[regionList: Region.list(), museumInstanceList: results, museumInstanceTotal: results.totalCount]	
	}
	
	def autocomplete = {		
		def results = [];
		
		if(params.term && params.term.length() > 0)
		{
			results = Museum.createCriteria().list
			{
				ilike("name", "%" + params.term + "%")
				projections 
				{	
					property("name")
				}
				maxResults 20
			}
		}
		
		render results as JSON
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
            redirect(action: "search")
        }
        else {
            [museumInstance: museumInstance]
        }
    }

    def edit = {
        def museumInstance = Museum.get(params.id)
        if (!museumInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'museum.label', default: 'Museum'), params.id])}"
            redirect(action: "search")
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
            redirect(action: "search")
        }
    }

    def delete = {
        def museumInstance = Museum.get(params.id)
        if (museumInstance) {
            try {
                museumInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'museum.label', default: 'Museum'), params.id])}"
                redirect(action: "search")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'museum.label', default: 'Museum'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'museum.label', default: 'Museum'), params.id])}"
            redirect(action: "search")
        }
    }
}
