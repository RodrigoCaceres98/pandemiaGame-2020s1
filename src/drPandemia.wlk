  
import manzanas.*


object doctor {
	var property position
	var property image = "Dr.Pandemia2.png"

	
	method moveteDerecha(){
		self.position(self.position().right(1))
	}
	
	method moveteIzquierda(){
		self.position(self.position().left(1))
	}
	
	method moveteArriba(){
		self.position(self.position().up(1))
	}
	
	method moveteAbajo(){
		self.position(self.position().down(1))
	}
	
	method moveteA(unaPosicion){
		self.position(unaPosicion)
	}
	method codigoEnPantalla() { return 2 }
}