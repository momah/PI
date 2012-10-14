class PiedraPapelTijera
  def initialize()
    #creamos el array de las tres opciones
	@piesas = %w[piedra papel tijera]
    #creamos un HASH para marcar cada pieza y la pieza que le gana ("indice" ganado por "valor")"
	@gana = {'piedra' => 'papel', 'papel' => 'tijera', 'tijera' => 'piedra'}
	#TODO
	@jugadas = {'piedra' => 1, 'papel' => 1, 'tijera' => 1}
	#ajusta a zero el marcador
    @marcador = [0, 0]
	
	#Llamar al metodo play que esta definido abajo.
    play
  end
 
  def jugadaHumano()
    #inicializar la variable repuesta con nil
    respuesta = nil
    #dentro de un bucle hacemos lo siguente...
    loop do
      #Elige una opcion.
      print "\nElige una opcion: " 
      #imprimir el array de las opciones por pantalla
      p @piesas 
      #recibir la eleccion del jugador por teclado
      respuesta = STDIN.gets.strip.downcase
    
      next if respuesta.empty?
      #buscar SI existe la opcion introducida en el array piesas
      if idx = @piesas.find_index {|piesa| piesa.match(/^#{respuesta}/)}
        #entoncez asignarla a la variable respuesta
        respuesta = @piesas[idx]
        break
      else
        #si no imprimir este mensage
        puts "Su Eleccion no es invalida,Por favor ententelo de nuevo."
      end
    end
    #devolver la variable respuesta
    respuesta
  end
 
  def jugadaComputadora()
    #sumar los valores los elementos del HASH @jugadas, ejemplo
    #@jugadas = {'piedra' => 1, 'papel' => 1, 'tijera' => 1}
    #@jugadas.values => 1 1 1 
    #@jugadas.values.reduce(:+) => 3
    total = @jugadas.values.reduce(:+)
    
    # r coje un valor aleatorio entra mayor que 1, (entre 0 y total)+1
    r = rand(total) + 1
    sum = 0
    #inicializar la variable humanoEleccion repuesta con nil
    humanoEleccion = nil
    # cada "ELEMENTO PIESA" de @jugadas = {'piedra' => n, 'papel' => m, 'tijera' => l}
    # sum = sum + n + m + l
    @piesas.each do |piesa|
      sum += @jugadas[piesa]
      #si "sum" es mayor o igual a el aleatorio "r"
      if r <= sum
        #humanoEleccion cojerá el actual "ELEMENTO PIESA"
        humanoEleccion = piesa
        break
      end
    end
    # devolver 
    @gana[humanoEleccion]
  end
 
  def play
    loop do
      #asignar los resultados de los metodos "jugadaHumano" y "jugadaComputadora" a los variables "h" y "c"
	  h = jugadaHumano
      c = jugadaComputadora
      #imprimir la jugada de cada uno con los resultados asignados a "h" y "c".
	  print "Humano: #{h}, Computadora: #{c} => "
	  # sólo actualizar el historial del jugador humano, después de que el la computadora haya elegido
      @jugadas[h] += 1
	  #Si la elección del humano igual a la de la maquina => Empate.
      if h == c
        puts "Empate!"
	  #buscamos en en al HASH @gana => si la elección del humano como "indice" tiene "valor" igual a la elección de la computadora 
      elsif h == @gana[c]
        puts "Ha Ganado el Humano!"
        #incrementar el contador del Humano
		@marcador[0] += 1
      else
        puts "Ha Ganado la Computadora!"
		#incrementar el contador de la maquina
        @marcador[1] += 1
      end
      # Mostrar resultado al final de cada jugada
	  puts "Marcador: Humano=#{@marcador[0]}, Computadora=#{@marcador[1]}"
    end
  end
end
# crear una instancia de PiedraPapelTijera => jugar
jugar = PiedraPapelTijera.new
