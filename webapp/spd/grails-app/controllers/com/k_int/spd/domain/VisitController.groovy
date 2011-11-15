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
		def affiliations = []
		def results = []
		
		if(user && user.roles.collect{it.name}.contains(AdminsService.ADMIN_ROLE) == false)
		{
			 affiliations = user.getAffiliationsByStatus(StatusEnum.ACCEPTED);
		}

		if(user && (user.roles.collect{it.name}.contains(AdminsService.ADMIN_ROLE) || affiliations.size() > 0))
		{
			results = Visit.createCriteria().list(max: params.max, offset: params.offset)
			{
				createAlias('museum', 'mus')
				createAlias('school', 'sch')
				and
				{
					if(params.museum) 	{ ilike("mus.name", "%" + params.museum + "%") }
					if(params.school)	{ ilike("sch.name", "%" + params.school + "%") }
					if(affiliations && affiliations?.size() > 0)//restrict to affiliate visits if NOT admin
					{
						'in'("mus.name", affiliations.collect{it.name})
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
		}
		[visitInstanceList: results, visitInstanceTotal: (results ? results.totalCount : 0)]
	}
		
	def create = 
	{
		def visitInstance = new Visit()
		visitInstance.properties = params		
		def classifiers = Classifier.findAllByClassificationLevel(0);
		return [visitInstance: visitInstance,topClassifiers: classifiers]
	}

	def save = {
			
		params.museum = Museum.findByName(params.museum.name)
		params.school = School.findByName(params.school.name)
		params.visitYear = params.visitDate.toCalendar().get(Calendar.YEAR);
			
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
