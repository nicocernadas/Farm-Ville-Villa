import wollok.game.*

object hector {
    var property image = 'player.png'
    var property position = game.center()
    var property monedas = 0
    const property plantasVenta = []

    method sembrar(plantita) {
        if(game.getObjectsIn(self.position()).size() == 1) {
            game.addVisual(plantita)
        }
    }

    method cosechar() {}

    method regar(_planta) {
        _planta.evoluciona()
    }

    method cosechar(_planta) {
        if (_planta.esAdulta()){
            _planta.cosechar()
            plantasVenta.add(_planta)            
        } else {
            game.say(self, "No es adulta!")
        }

    }

}
class Planta {
    var evolucion = 0
    var property position

    method evoluciona() {
        if (evolucion == 0) {
            evolucion += 1
        }
    }

    method esAdulta() {
        return evolucion >= 1
    }

    method puedeSembrar(_position) {
        return self.position()
    }

    method cosechar() {
      game.removeVisual(self)
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
            if (self.position().y().between(0, 18))
            position = self.position().up(1) 
            
        }
    }
    method image() {
        if (evolucion == 0) {
            return 'tomaco_baby.png'
        } else {
            return 'tomaco.png'
        }
    }     
    override method esAdulta() {
      return true
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
    override method esAdulta() {
        return evolucion >= 2
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
        config.configurarTeclas()
        game.addVisualCharacter(hector)

        game.start()
    }
}


object config {
    method configurarTeclas() {

        keyboard.m().onPressDo({ 
            hector.sembrar(new Maiz(position = hector.position())) })
        keyboard.t().onPressDo({
            hector.sembrar(new Trigo(position = hector.position()))
        })
        keyboard.o().onPressDo({
            hector.sembrar(new Tomaco(position = hector.position()))
        })

        keyboard.r().onPressDo({
            hector.regar(game.getObjectsIn(hector.position()).get(1))
        })

        keyboard.c().onPressDo({
            if(game.getObjectsIn(hector.position()).size() == 2)
                hector.cosechar(game.getObjectsIn(hector.position()).get(1))
            else
                game.say(hector, "No tengo nada para cosechar")
        })

        keyboard.s().onPressDo({game.say(hector, hector.plantasVenta().toString())})
    }
}