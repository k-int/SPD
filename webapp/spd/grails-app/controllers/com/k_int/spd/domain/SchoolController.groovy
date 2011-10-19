package com.k_int.spd.domain

import grails.converters.*

class SchoolController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "search", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [schoolInstanceList: School.list(params), schoolInstanceTotal: School.count()]
    }
	
	def search = {
		
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		
		def results = School.createCriteria().list(max: params.max, offset: params.offset)
		{
			and
			{
				if(params.name) 	{ ilike("name", "%" + params.name + "%") }
				if(params.oldSpdId)	{ eq("oldSpdId", params.long('oldSpdId')) }
				if(params.region)	{ eq("region.id", params.long('region')) }
				if(params.sort && params.order) { order(params.sort, params.order)}
			}
		}
		[regionList: Region.list(), schoolInstanceList: results,schoolInstanceTotal:results.totalCount]
	}
	
	def autocomplete = {
		
		def results = [];
		
		if(params.term && params.term.length() > 0)
		{
			results = School.createCriteria().list
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
        def schoolInstance = new School()
        schoolInstance.properties = params
        return [schoolInstance: schoolInstance]
    }

    def save = {
        def schoolInstance = new School(params)
        if (schoolInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'school.label', default: 'School'), schoolInstance.id])}"
            redirect(action: "show", id: schoolInstance.id)
        }
        else {
            render(view: "create", model: [schoolInstance: schoolInstance])
        }
    }

    def show = {
        def schoolInstance = School.get(params.id)
        if (!schoolInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'school.label', default: 'School'), params.id])}"
            redirect(action: "search")
        }
        else {
            [schoolInstance: schoolInstance]
        }
    }

    def edit = {
        def schoolInstance = School.get(params.id)
        if (!schoolInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'school.label', default: 'School'), params.id])}"
            redirect(action: "search")
        }
        else {
            return [schoolInstance: schoolInstance]
        }
    }

    def update = {
        def schoolInstance = School.get(params.id)
        if (schoolInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (schoolInstance.version > version) {
                    
                    schoolInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'school.label', default: 'School')] as Object[], "Another user has updated this School while you were editing")
                    render(view: "edit", model: [schoolInstance: schoolInstance])
                    return
                }
            }
            schoolInstance.properties = params
            if (!schoolInstance.hasErrors() && schoolInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'school.label', default: 'School'), schoolInstance.id])}"
                redirect(action: "show", id: schoolInstance.id)
            }
            else {
                render(view: "edit", model: [schoolInstance: schoolInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'school.label', default: 'School'), params.id])}"
            redirect(action: "search")
        }
    }

    def delete = {
        def schoolInstance = School.get(params.id)
        if (schoolInstance) {
            try {
                schoolInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'school.label', default: 'School'), params.id])}"
                redirect(action: "search")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'school.label', default: 'School'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'school.label', default: 'School'), params.id])}"
            redirect(action: "search")
        }
    }
}
