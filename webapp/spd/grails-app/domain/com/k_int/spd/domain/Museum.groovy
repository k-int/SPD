package com.k_int.spd.domain

class Museum {

  String name
  Long oldSpdId

    static constraints = {
      oldSpdId(nullable:true)
    }


}
