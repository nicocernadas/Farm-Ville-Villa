import wollok.game.*
object hector {
    var property image = 'player.png'
    var property position = game.center()
    var property monedas = 0

    method sembrar(plantita) {
        if(game.getObjectsIn(self.position()).size() == 1) {
            game.addVisual(plantita)
        }
    }

    method cosechar() {}

    method regar(_planta) {
        _planta.evoluciona()
    }
}

object aspersor {
    var property image = 'aspersor.png'
    var property position = game.at(10, 10)

    method regar() {
        if (game.getObjectsIn(self.position().up(1)) == 1) {
            game.getObjectsIn(self.position().up(1)).get(0).evoluciona()
        } else if (game.getObjectsIn(self.position().down(1)) == 1) {
            game.getObjectsIn(self.position().down(1)).get(0).evoluciona()
        } else if (game.getObjectsIn(self.position().right(1)) == 1) {
            game.getObjectsIn(self.position().right(1)).get(0).evoluciona()
        } else if (game.getObjectsIn(self.position().left(1)) == 1) {
            game.getObjectsIn(self.position().left(1)).get(0).evoluciona()
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
        config.configurarTeclas()
        game.addVisualCharacter(hector)
        game.addVisual(aspersor)
        game.onTick(5000, "riega plantas up,down,left,right", {aspersor.regar()})

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
    }
}