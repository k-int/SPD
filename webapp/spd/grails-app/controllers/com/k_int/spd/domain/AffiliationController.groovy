package com.k_int.spd.domain

import com.k_int.spd.utils.StatusEnum

class AffiliationController {

    def index = { }
	
	def create = 
	{
		def affiliationInstance = new Affiliation()
		affiliationInstance.properties = params
		return [affiliationInstance: affiliationInstance]
	}
	
	def save = 
	{
		def userInstance = User.findById(params.user.id)
		def museumInstance = Museum.findById(params.museum.id)
		def affiliationInstance = Affiliation.link(userInstance, museumInstance)
		
		if (affiliationInstance) 
		{
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'affiliation.label', default: 'Affiliation'), affiliationInstance.id])}"
			redirect(action: "list")
		}
		else
		{
			render(view: "create", model: [affiliationInstance: affiliationInstance])
		}
	}
	
	def grant = 
	{
		def affiliationInstance = Affiliation.get(params.id) 
		if(affiliationInstance)
		{
			affiliationInstance.status = StatusEnum.ACCEPTED;
			affiliationInstance.save(flush: true)
			redirect(action: "list")
		}
		else
		{
			render(view: "list", model: [affiliationInstance: affiliationInstance])
		}
	}
	
	def reject =
	{
		def affiliationInstance = Affiliation.get(params.id) 
		if(affiliationInstance)
		{
			affiliationInstance.status = StatusEnum.REJECTED;
			affiliationInstance.save(flush: true)
			redirect(action: "list")
		}
		else
		{
			render(view: "list", model: [affiliationInstance: affiliationInstance])
		}
	}
	
	def list =
	{
		def results
		
		if(params.user?.id)
		{
			def userInstance = User.findById(params.user.id)
			
			results = Affiliation.findAllByUser(userInstance)
		}
		else
		{
			results = Affiliation.list()
		}
		
		[affiliationInstanceList: results, affiliationInstanceTotal: results.size ? results.size : 0]
	}
	
	def delete = 
	{
		Affiliation.unlink(params.id)
		redirect(action: "list")
	}

}
