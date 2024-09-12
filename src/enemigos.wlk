import capos.*

object erethia{
    const habitantes = #{archibaldo, caterina, astra}

    method esPoderoso(personaje){
        return habitantes.all( { habitante => personaje.puedeVencer(habitante)})
            //.all() : si todos los objetos cumplen la condicion
    }

    method conquistable(personaje) {
        return self.vencibles(personaje).map( { habitante => habitante.casa()} ).asSet()
    }
    //.map SIEMPRE devuelve una lista, porque si fuera un set y se repiten elementos se eliminarian.  

    method vencibles(personaje){
        return habitantes.filter( { habitante => personaje.puedeVencer(habitante)})
    }
}
object archibaldo{
    var casa = palacioMarmol

    method poder(){
        return 16
    }

    method casa(){
        return casa
    }



}
object caterina{
    var casa = fortalezaAcero
    method poder(){
        return 28
    }
    method casa(){
        return casa
    }
}

object astra{
    var casa = torreMarfil
    method poder(){
        return 14
    }
    method casa(){
        return casa
    }
}

object palacioMarmol{

}
object fortalezaAcero{

}
object torreMarfil{

}

