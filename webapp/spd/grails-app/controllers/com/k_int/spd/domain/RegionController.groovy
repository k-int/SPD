package com.k_int.spd.domain

class RegionController {

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [regionInstanceList: Region.list(params), regionInstanceTotal: Region.count()]
    }
	
	
	def create = {
		def regionInstance = new Region()
		regionInstance.properties = params
		return [regionInstance: regionInstance]
	}
	
	def save = {
		def regionInstance = new Region(params)
		if (regionInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'region.label', default: 'Region'),regionInstance.id])}"
			redirect(action: "show", id: regionInstance.id)
		}
		else {
			render(view: "create", model: [regionInstance: regionInstance])
		}
	}
	
	def show = {
		def regionInstance = Region.get(params.id)
		if (!regionInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'region.label', default: 'Region'), params.id])}"
			redirect(action: "list")
		}
		else {
			[regionInstance: regionInstance]
		}
	}

	def edit = {
		def regionInstance = Region.get(params.id)
		if (!regionInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'region.label', default: 'Region'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [regionInstance: regionInstance]
		}
	}
	
	def update = {
		def regionInstance = Region.get(params.id)
		if (regionInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (regionInstance.version > version) {
					
					regionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'region.label', default: 'Region')] as Object[], "Another user has updated this Region while you were editing")
					render(view: "edit", model: [regionInstance: regionInstance])
					return
				}
			}
			regionInstance.properties = params
			if (!regionInstance.hasErrors() && regionInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'region.label', default: 'Region'), regionInstance.id])}"
				redirect(action: "show", id: regionInstance.id)
			}
			else {
				render(view: "edit", model: [regionInstance: regionInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'region.label', default: 'Region'), params.id])}"
			redirect(action: "list")
		}
	}
	
	def delete = {
        def regionInstance = Region.get(params.id)
        if (regionInstance) {
            try {
                regionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'region.label', default: 'Region'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'region.label', default: 'Region'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'region.label', default: 'Region'), params.id])}"
            redirect(action: "list")
        }
    }
}
