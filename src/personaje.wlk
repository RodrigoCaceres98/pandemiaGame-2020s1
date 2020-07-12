object pandemia {
	var property position
	var property image = "player.png"
	
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
	
	method movete() {
		const x = 0.randomUpTo(self.position().width()).truncate(0)
		const y = 0.randomUpTo(self.position().height()).truncate(0)
		position = self.position().at(x,y) 
	}
	
	method codigoEnPantalla() { return 1 }
}