package com.k_int.spd.domain

class VisitController {

    def index = { }
	
	def create = {
		def visitInstance = new Visit()
		visitInstance.properties = params
		return [visitInstance: visitInstance]
	}

	def save = {
		def visitInstance = new Visit(params)
		if (visitInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'visit.label', default: 'Visit'), visitInstance.id])}"
			redirect(action: "show", id: visitInstance.id)
		}
		else {
			render(view: "create", model: [visitInstance: visitInstance])
		}
	}
}
