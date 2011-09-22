package com.k_int.spd.utils

enum StatusEnum 
{
	PENDING("Pending"), ACCEPTED("Accepted"), REJECTED("Rejected")	

	StatusEnum(String value) { this.value = value }
	
	private final String value
	
	public String value() { return value }
}
