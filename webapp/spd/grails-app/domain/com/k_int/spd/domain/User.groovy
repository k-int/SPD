
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
}
