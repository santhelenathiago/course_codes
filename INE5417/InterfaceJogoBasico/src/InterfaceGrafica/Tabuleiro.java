package InterfaceGrafica;

import java.awt.GridLayout;
import java.awt.LayoutManager;

import javax.swing.JPanel;
import javax.swing.border.Border;

public class Tabuleiro extends JPanel {
	protected Posicao posicoes[][] = new Posicao[8][8];
	
	public Tabuleiro() {
		this.setSize(480, 480);
		GridLayout layout = new GridLayout(8, 8);
		this.setLayout(layout);
		for (int y = 0; y < 8; y++) {
			for (int x = 0; x < 8; x++) {
				this.posicoes[x][y] = new Posicao(x, y);
				this.add(this.posicoes[x][y]);
			}
		}
	}

	public Tabuleiro(LayoutManager arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}

	public Tabuleiro(boolean arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}

	public Tabuleiro(LayoutManager arg0, boolean arg1) {
		super(arg0, arg1);
		// TODO Auto-generated constructor stub
	}

}
