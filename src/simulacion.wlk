import personas.*
import manzanas.*

object simulacion {
	var property diaActual = 0
	const property manzanas = []
	
	// parametros del juego
	const property chanceDePresentarSintomas = 30
	const property chanceDeContagioSinCuarentena = 25
	const property chanceDeContagioConCuarentena = 2
	const property personasPorManzana = 10
	const property duracionInfeccion = 20

	/*
	 * este sirve para generar un azar
	 * p.ej. si quiero que algo pase con 30% de probabilidad pongo
	 * if (simulacion.tomarChance(30)) { ... } 
	 */
	method tomarChance(porcentaje) { return (0.randomUpTo(100) < porcentaje) }
	
	// agrega una manzana a la simulzacion
	method agregarManzana(manzana) { manzanas.add(manzana) }
	
	// retorna un booleano
	method debeInfectarsePersona(persona,cantidadContagiadores) {  
		var siContagia = []
		const chanceDeContagio = 
		if (persona.respetaCuarentena()) { // FALTA METODO EN PERSONA: persona.respetaCuarentena() -> retorna booleano
			self.chanceDeContagioConCuarentena() } 
		else { 
				self.chanceDeContagioSinCuarentena()
			}
		if (persona.respetaCuarentena()) { siContagia = [1] } else { siContagia = [1,2,3,4] }
		return  siContagia.any({n => self.tomarChance(chanceDeContagio)})
		/// revisar
			// la logica de 1 pasada si es hay un contagio o 4, va aca.
			// (1..cantidadContagiadores).any({n => self.tomarChance(chanceDeContagio) 
   			// retorna un booleano 
	}
	
	// define al azar si la persona tendra sintomas o no.
	method debeTenerSintomas(persona) { // FALTA METODO EN PERSONA: persona.presentaSintomas(booleno)
		persona.presentaSintomas(self.tomarChance(self.chanceDePresentarSintomas()))
	}
	
	/* define al azar (30% / 60%) si la persona estara aislada o NO, cuando no esta infectada
	method estaraAisladaONo(persona) { 
		if (not persona.presentaSintomas()) {
			persona.estaAislada(self.tomarChance(30))
		}
	}
	*/
	// simmula la decision de las personas a quedarse aisladas o no
	method decidirAislarseONo() {
		manzanas.forEach( { manzana => manzana.simulacionDecisionDeAislarse() } )
	}
	
	// translado o movimiento de un habitante entre manzanas
	method transladarHabitante(manzana) { 
		manzana.transladoDeUnHabitante()
	} 
		
	// simula la propagacion del contagio
	method propagacionContagio() { 
		manzanas.forEach( { manzana => manzana.simulacionContagiosDiarios() } )
	}
	
	// simula el translado de personas entre manzanas
	method transladoDePersonas() {
		manzanas.forEach( { manzana => self.transladarHabitante(manzana) } )
	}
	
	// simula la curacion de personas, pasada los 20 dias
	method ejecutarCuracion() {
		manzanas.forEach( { manzana => manzana.simulacionCuracion() } )
	}
	
	// retorna una manzanda al azar
	method elegirUnaManzanaAlAzar() { 
		return manzanas.get(0.randomUpTo(manzanas.size() - 1)) 
	}
	
	// simular caso importando de persona infectada
	method importarCaso() {
		const personaInfectada = new Persona()
		personaInfectada.infectarse()
		personaInfectada.presentaSintomas(false)
		self.elegirUnaManzanaAlAzar().mudarAEstaManzana(personaInfectada)
	}
	
	// simula el avance de un dia en pandemia
	method avanzarUnDia() { 
		self.diaActual(self.diaActual() + 1)
		self.transladoDePersonas()
		self.propagacionContagio()
		self.ejecutarCuracion()
	}

	method crearManzana() {
		const nuevaManzana = new Manzana()
		// agregar la cantidad de personas segun self.personasPorManzana()
		const persona = new Persona()
		//{persona => nuevaManzana.mudarAEstaManzana(persona)}.apply(self.personasPorManzana()) ///
		/* nuevaManzana.mudarAEstaManzana(persona)
		nuevaManzana.mudarAEstaManzana(persona)
		nuevaManzana.mudarAEstaManzana(persona)
		nuevaManzana.mudarAEstaManzana(persona)
		nuevaManzana.mudarAEstaManzana(persona)
		nuevaManzana.mudarAEstaManzana(persona)
		nuevaManzana.mudarAEstaManzana(persona)
		nuevaManzana.mudarAEstaManzana(persona)
		nuevaManzana.mudarAEstaManzana(persona)
		nuevaManzana.mudarAEstaManzana(persona)
		*/
		self.personasPorManzana().times({ veces => nuevaManzana.mudarAEstaManzana(persona) })  
		return nuevaManzana
	}
	
	// Consultas:
	// sumar cantidad de personas del barrio.
	method cuantasPersonasVivenEnelBarrio() {
		return manzanas.sum( { manzana => manzana.cuantaGenteVive() } )
	}
	
	// sumar cantidad de personas aisladas en la simunacion del barrio
	method cuantasPersonasEstanAisladas() {
		return manzanas.sum( { manzana => manzana.cuantasPersonasEstanAisladas() } )	
	}
	
	// sumar la cantidad de personas infectadas en la simulacion del barrio
	method cuantasPersonasEstanInfectadas() {
		return manzanas.sum( { manzana => manzana.cuantasPersonasEstanInfectadas() } )	
	}
	
	// sumar al cantidad de personas con sintomas en la simulacion del barrio
	method cuantasPersonasTienenSintomas() {
		return manzanas.sum( { manzana => manzana.cuantasPersonasTienenSintomas() } )
	}
}
