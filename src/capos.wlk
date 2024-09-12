import enemigos.*

object espada{
        var  fueUsado = false

        method poder(personaje){
            return personaje.poderBase() * self.factorPorUso()
        }

        method serUsado(){
            fueUsado = true
        }

        method factorPorUso(){
            return if(fueUsado) 0.5 else 1
        }
}

object collar {
    var usos = 0

    method poder(personaje){
        return 3 + self.extraPorNivel(personaje)
    }

    method extraPorNivel(personaje){
        return if(personaje.poderBase() > 6) usos else 0
    }

    method serUsado(){
        usos += 1
    }

}

object armadura {

    method poder(personaje){
        return 6
    }

    method serUsado(){

    }

}

object libro {

    const hechizos = []

    method hechizos(_hechizos){
        hechizos.addAll(_hechizos)
    }

	method poder(personaje){
        return if(self.quedanHechizos()) self.hechizoActual().poderHechizo(personaje) else 0
    }

    method quedanHechizos(){
        return !hechizos.isEmpty()
    }


    method serUsado(){
        hechizos.remove(self.hechizoActual())
    } 

    method hechizoActual(){
        return hechizos.head()
    }
}
// HECHIZOS
object bendicion{
    method poderHechizo(personaje){
        return 4
    }
}
object invisibilidad{
    method poderHechizo(personaje){
        return personaje.poderBase()
    }
}
object invocacion{
    method poderHechizo(personaje){
        return personaje.artefactoMasPoderosoCasa().poder(personaje)
    }
}


object castillo {
	
	const property artefactos = #{}
		
	method agregarArtefactos(_artefactos) {
		artefactos.addAll(_artefactos)		
	}

    method artefactoMasPoderoso(personaje){
        return artefactos.max( { artefacto => artefacto.poder(personaje)} )
    }
	
}


object rolando {

	const property artefactos = #{}
	var property capacidad = 2
	const casa = castillo
	const property historia = []
    var  poderBase = 5

    method tieneArmaFatal(enemigo){
        return artefactos.any( { artefacto => artefacto.poder(self) > enemigo.poder() })
    }

    method armaFatal(enemigo){  //parcial, puede fallar
        return artefactos.find( { artefacto => artefacto.poder(self) > enemigo.poder()})
    }

    method puedeVencer(enemigo){
        return self.poder() > enemigo.poder()
    }


    method poder(){
        return poderBase + self.poderArtefactos()
    }

    method poderBase(){
        return poderBase
    }
    method poderBase(_poderBase){
        poderBase = _poderBase
    }

    method poderArtefactos(){
        return artefactos.sum({artefacto => artefacto.poder(self)})
    }

    method batalla(){
        self.usarArtefactos()
        poderBase += 1
    }

    method usarArtefactos(){
            artefactos.forEach( { artefacto => artefacto.serUsado()})

    }

    method artefactoMasPoderosoCasa(){
        return casa.artefactoMasPoderoso(self)

    }

	method encontrar(artefacto) {
		if(artefactos.size() < capacidad) {
			artefactos.add(artefacto)
		}
		historia.add(artefacto)
	}
	
	method volverACasa() {
		casa.agregarArtefactos(artefactos)
		artefactos.clear()
	}	
	
	method posesiones() {
		return self.artefactos() + casa.artefactos()
	}
	
	method posee(artefacto) {
		return self.posesiones().contains(artefacto)	
	}



    method casa(){
        return casa
    }		
}

