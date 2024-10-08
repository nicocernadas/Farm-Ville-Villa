import wollok.game.*

object hector {
    var property image = 'player.png'
    var property position = game.center()
    var property monedas = 0

    method sembrar(plantita) {
        if(game.getObjectsIn(self.position()).size() == 0) {
            game.addVisual(plantita)
        }
    }

    method cosechar() {}

    method regar(_planta) {
        _planta.evoluciona()
    }
}
class Planta {
    var evolucion = 0
    var property position = null

    method evoluciona() {
        if (evolucion == 0) {
            evolucion += 1
        }
    }

    method esGrande() {
        return evolucion >= 1
    }

    method puedeSembrar(_position) {
        return self.position()
    }
}

class Maiz inherits Planta() {
    method image() {
        if (evolucion == 0) {
            return 'corn_baby.png'
        } else {
            return 'corn_adult.png'
        }
    }
} 

class Tomaco inherits Planta() {

    override method evoluciona() {
        if (evolucion == 0) {
            evolucion += 1
        } else {
            self.position().x() + 1
        }
    }
    method image() {
        if (evolucion == 0) {
            return 'tomaco_baby.png'
        } else {
            return 'tomaco.png'
        }
    }     
}

class Trigo inherits Planta() {

    override method evoluciona() {
        if (evolucion == 3) {
            evolucion = 0
        } else {
            evolucion += 1
        }
    }
    override method esGrande() {
        return evolucion == 3
    }

    method image() {
      if(evolucion == 0) {
        return 'wheat_0.png'
      } else if (evolucion == 1) {
        return 'wheat_1.png'
      } else if (evolucion == 2) {
        return 'wheat_2.png'
      } else {
        return 'wheat_3.png'
      }
    }
}



















object nivel1 {
    method iniciar() {
        // config.configurarTeclas()
        game.addVisualCharacter(hector)






        game.start()
    }
}


object config {
    method configurarTeclas() {
        keyboard.m().onPressDo({ 
            const maiz = new Maiz() 
            hector.sembrar(maiz) })
        keyboard.t().onPressDo({
            const trigo = new Trigo()
            hector.sembrar(trigo)
        })
        keyboard.o().onPressDo({
            const tomaco = new Tomaco()
            hector.sembrar(tomaco)
        })

        keyboard.r().onpPressDo({})
    }
}