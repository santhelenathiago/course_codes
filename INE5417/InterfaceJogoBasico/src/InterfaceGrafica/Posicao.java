package InterfaceGrafica;

import java.awt.Color;

import javax.swing.Action;
import javax.swing.Icon;
import javax.swing.JButton;

public class Posicao extends JButton {
	protected int x;
	protected int y;
	
	public Posicao(int x, int y) {
		super();
		
		this.setBorderPainted(false);
		
		// Define posição no tabuleiro
		this.x = x;
		this.y = y;
		if (x%2 == y%2) {
			this.setBackground(new Color(255, 255, 255));
		} else {
			this.setBackground(new Color(0, 0, 0));
		}
		
		// Fixa tamanho do botão
		this.setSize(60, 60);
		this.setToolTipText("(" + x + ", " + y + ")");
	}

	public Posicao(Icon arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}

	public Posicao(String arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}

	public Posicao(Action arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}

	public Posicao(String arg0, Icon arg1) {
		super(arg0, arg1);
		// TODO Auto-generated constructor stub
	}

}
