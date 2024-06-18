# X0s App 
Alumno: Dianelys Saldaña López

## Descripción general del proyecto
X0s es juego que utiliza la tecnología de MultipeerConnectivity para permitir a dos jugadores competir entre sí en tiempo real desde diferentes dispositivos iOS.

## Breve descripción de cada una de las funcionalidades o clases de la aplicación

### GameView
- Representa la vista principal del juego. Utiliza SwiftUI para construir la interfaz de usuario basada en el estado y los datos proporcionados por los servicios GameService y MPConnectionManager.

### GameService 
- Es un servicio observador que gestiona el estado y la lógica del juego. Utiliza @Published para exponer propiedades que se actualizan automáticamente cuando cambian. Esta clase maneja la lógica del juego, incluyendo la gestión de jugadores, movimientos, el estado del tablero y la lógica para determinar el ganador.

### GameSquare
- Representa cada casilla individual del tablero del juego. Cada instancia de GameSquare contiene información sobre su identificador único (id) y el jugador que ha ocupado la casilla (player). Además, proporciona una propiedad (image) que devuelve una imagen representativa del jugador (X o O) o un icono en blanco si la casilla está vacío.

### SquareView
- Contiene la implementación de la vista diseñada para representar visualmente una casilla individual del juego X0s (tipo Tic-Tac-Toe). Cada instancia de SquareView se encarga de mostrar una de las 9 casillas del tablero.

### MPConnectionManager
- Esta clase se encarga de manejar aspectos clave de la conectividad entre dispositivos, incluyendo la publicidad y búsqueda de pares disponibles, el manejo de sesiones de comunicación, el envío y recepción de datos del juego, y la gestión del estado de conexión entre pares usando el MultipeerConnectivity framework.

### MPGameMove
- Encapsula la información sobre la acción realizada en el juego, incluyendo el tipo de acción (Action), el nombre del jugador (playerName) y un índice (index) que indica la posición en el tablero. Este MPGameMove see utilixza en send(gameMove).

### MPPeersView
- Esta vista se encarga de mostrar una lista de jugadores disponibles para iniciar una partida. Utiliza el entorno (EnvironmentObject) para acceder al MPConnectionManager y al GameService.

### StartView
- Esta vista es la vista principal que maneja la selección de pares disponibles (MPPeersView), y la transición al juego real (GameView) una vez que se inicia la partida. 

## Dificultades encontradas y cómo se han resuelto
- El manejo de conexiones con otros dispositivos, aasi como integrar y gestionar correctamente la conectividad multijugador utilizando MultipeerConnectivity fue algo complejo debido a la necesidad de manejar la publicidad, el descubrimiento de pares, más el intercambio de datos y las invitaciones de manera robusta y eficiente.
    - Solución: Se implementó la clase MPConnectionManager que encapsula toda la lógica relacionada con MultipeerConnectivity. Esta clase maneja la creación de sesiones, publicidad, descubrimiento de pares y comunicación de datos. Además, se utilicé los disstintos delegados (MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate, MCSessionDelegate) para manejar los distintos eventos, invitaciones y recepción de datos entre los pares de una forma más estructurada.
    
- Estructurar correctamente el rol del host y el cliente de manera que el comportamiento de ambos fuera el esperado fue una tarea ardua.
    - Solución: Organizé y estructuré el flujo de los datos para ambos jugadores. Me apoyé de tutoriales y foros relacionados a este tema.

## Preview
[![Watch the video](https://img.youtube.com/vi/Rm-bGl21HuA/maxresdefault.jpg)](https://youtu.be/Rm-bGl21HuA)
