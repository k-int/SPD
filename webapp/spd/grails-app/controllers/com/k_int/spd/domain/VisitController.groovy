package com.k_int.spd.domain

import org.apache.shiro.SecurityUtils
import grails.plugins.nimble.core.AdminsService
import com.k_int.spd.utils.StatusEnum

class VisitController {

    def index = {
		redirect(action: "search", params: params) 
	}
	
	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[visitInstanceList: Visit.list(params), visitInstanceTotal: Visit.count()]
	}
		
	def search = {
		
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		
		def user = User.get(SecurityUtils.getSubject()?.getPrincipal())
		
		def results = Visit.createCriteria().list(max: params.max, offset: params.offset)
		{
			createAlias('museum', 'mus')
			createAlias('school', 'sch')
			and
			{
				if(params.museum) 	{ ilike("mus.name", "%" + params.museum + "%") }
				if(params.school)	{ ilike("sch.name", "%" + params.school + "%") }
				if(user && user.roles.collect{it.name}.contains(AdminsService.ADMIN_ROLE) == false)//restrict to affiliate visits if NOT admin
				{
					'in'("mus.name", user.getAffiliationsByStatus(StatusEnum.ACCEPTED).collect{it.name})
				}
				if(params.sort && params.order) 
				{ 
					if(params.sort == 'museum.name'){		order("mus.name", params.order)}
					else if(params.sort == 'school.name'){	order("sch.name", params.order)}
					else
					{									
						order(params.sort, params.order)
					}
				}
			}
		}
		[visitInstanceList: results,visitInstanceTotal:results.totalCount]
	}
		
	def create = 
	{
		def visitInstance = new Visit()
		visitInstance.properties = params
		return [visitInstance: visitInstance]
	}

	def save = {
		params.museum = Museum.findByName(params.museum.name)
		params.school = School.findByName(params.school.name)
		def visitInstance = new Visit(params)
		if (visitInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'visit.label', default: 'Visit'), visitInstance.id])}"
			redirect(action: "search", id: visitInstance.id)
		}
		else {
			render(view: "create", model: [visitInstance: visitInstance])
		}
	}
}
