package InterfaceGrafica;

import java.awt.Color;
import java.awt.GridLayout;
import java.awt.LayoutManager;

import javax.swing.JPanel;

public class ControladorDeCartas extends PanelArredondado {
	protected Carta[] deck = new Carta[10];
	protected Carta[] mao = new Carta[5];
	protected Carta[] descarte = new Carta[10];

	public ControladorDeCartas() {
		super();
		GridLayout layout = new GridLayout(1, 5);
		layout.setVgap(2);
		layout.setHgap(5);
		this.setLayout(layout);
		
		this.setSize(680, 180);

		// Fazer inicialização das cartas aqui
		
		// Colocar 5 cartas aleatórias na mão
		
		// Gambiarrinha só pra mostrar pro professor
		for (int i = 0; i < mao.length; i++) {
			this.mao[i] = new Carta(TiposCartas.DEFAULT);
			this.add(this.mao[i], 0, i);
		}
	}
}
