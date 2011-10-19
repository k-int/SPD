
package com.k_int.spd.domain

import com.k_int.spd.utils.StatusEnum

class User extends grails.plugins.nimble.core.UserBase
{
	static hasMany = [affiliations:Affiliation]
	
	List allAffiliations() 
	{ 
		return affiliations.collect{it.museum} 
	}
	
	List getAffiliationsByStatus(StatusEnum status)
	{
		return affiliations.findAll{ a -> a.status == status}.collect{it.museum}
	}
	
	List addToAffiliations(Museum museum) 
	{ 
		Affiliation.link(this, museum) 
		return allAffiliations() 
	}
	
	List removeFromAffiliations(Museum museum) 
	{ 
		Affiliation.unlink(this, museum) 
		return allAffiliations() 
	}
	
	/*def listaffiliates = {
		def user = UserBase.get(params.id)
		if (!user) {
			log.warn("User identified by id '$params.id' was not located")
			render message(code: 'nimble.user.nonexistant', args: [params.id])
			response.status = 500
		}
		else {
			log.debug("Listing affiliates user [$user.id]$user.username is granted")
			render(template: '/templates/admin/permissions_list', contextPath: pluginContextPath, model: [permissions: user.permissions, parent: user])
		}
	}
	
	def createaffiliate = {
		def user = UserBase.get(params.id)
		if (!user)
		{
			log.warn("User identified by id '$params.id' was not located")
			render message(code: 'nimble.user.nonexistant', args: [params.id])
			response.status = 500
		}
		else 
		{
			LevelPermission permission = new LevelPermission()
			permission.populate(params.first, params.second, params.third, params.fourth, params.fifth, params.sixth)
			permission.managed = false
	
			if (permission.hasErrors()) 
			{
				log.warn("Creating new permission for user [$user.id]$user.username failed, permission is invalid")
				render(template: "/templates/errors", contextPath: pluginContextPath, model: [bean: permission])
				response.status = 500
			}
			else
			{
				def savedPermission = permissionService.createPermission(permission, user)
				log.info("Creating new permission for user [$user.id]$user.username succeeded")
				render message(code: 'nimble.permission.create.success', args: [user.username])
			}
		}
	}
	
	def removepermission = 
	{
		def user = UserBase.get(params.id)
		if (!user) 
		{
			log.warn("User identified by id '$params.id' was not located")
			render message(code: 'nimble.user.nonexistant', args: [params.id])
			response.status = 500
		}
		else 
		{
			def permission = Permission.get(params.permID)
			
			if (!permission) 
			{
				log.warn("Permission identified by id '$params.permID' was not located")
				render message(code: 'nimble.permission.nonexistant', args: [params.permID])
				response.status = 500
			}
			else 
			{
				permissionService.deletePermission(permission)
				log.info("Removing permission [$permission.id] from user [$user.id]$user.username succeeded")
				render message(code: 'nimble.permission.remove.success', args: [user.username])
			}
		}
	}*/
}
