package InterfaceGrafica;

import java.awt.BorderLayout;
import java.awt.Graphics;

import javax.swing.BorderFactory;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;

import net.miginfocom.swing.MigLayout;

import java.awt.GridLayout;
import java.net.URL;

import javax.swing.Box;


public class InformacoesDeJogo extends PanelArredondado {
	private InformacoesDeJogador jogador, oponente;
	private JLabel faseDoTurno;
	private JLabel jogadorAtivo;
	private Box verticalBox;

	public InformacoesDeJogo() {
		this.setSize(190, 480);
		BorderLayout layout = new BorderLayout(25, 25);
		setLayout(layout);
		
		setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
		
		this.jogador = new InformacoesDeJogador();
		this.oponente = new InformacoesDeJogador();
		this.faseDoTurno = new JLabel();
		this.jogadorAtivo = new JLabel();
		
		// Testing Purposes
		jogador.setNome("Jogador Local");
		oponente.setNome("Jogador em Rede");
		
		jogador.setCartasDeck(5);
		oponente.setCartasDeck(5);
		
		jogador.setCartasMao(5);
		oponente.setCartasMao(5);
		
		jogador.setCartasDescarte(0);
		oponente.setCartasDescarte(0);
		
		faseDoTurno.setText("Aguardando uso de carta");
		jogadorAtivo.setText("Seu turno");
		// End testing Purposes
		URL url = getClass().getResource("/kingCrown.png");
		JLabel logo = new JLabel(new ImageIcon(url));
		verticalBox = Box.createVerticalBox();		
		verticalBox.add(logo);
		verticalBox.add(this.jogadorAtivo);
		verticalBox.add(this.faseDoTurno);
		
		
		this.add(this.oponente, BorderLayout.NORTH);
		this.add(verticalBox, BorderLayout.WEST);
		this.add(this.jogador, BorderLayout.SOUTH);
		
	}
	
	public String getJogadorAtivo() {
		return jogadorAtivo.getText();
	}

	public void setJogadorAtivo(String faseDoTurno) {
		this.jogadorAtivo.setText(faseDoTurno);
	}

	public String getFaseDoTurno() {
		return faseDoTurno.getText();
	}

	public void setFaseDoTurno(String faseDoTurno) {
		this.faseDoTurno.setText(faseDoTurno);
	}
}
