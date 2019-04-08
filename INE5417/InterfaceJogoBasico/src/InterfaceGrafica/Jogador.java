package InterfaceGrafica;

public class Jogador {	
	protected ControladorDeCartas controlador;
	protected String nome;
//	protected pecas Peca;
	protected boolean podeUsarCarta;

	public Jogador() {
		
		// Inicializa controlador de cartas do jogador
		controlador = new ControladorDeCartas();
		controlador.setLocation(10, 520);
	}


	public ControladorDeCartas getControlador() {
		return controlador;
	}
}
