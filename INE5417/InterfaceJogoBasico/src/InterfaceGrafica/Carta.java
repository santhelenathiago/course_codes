package InterfaceGrafica;

import java.awt.Color;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.net.URL;

import javax.swing.BorderFactory;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

public class Carta extends JLabel {
	protected TiposCartas tipo;
	public Carta(TiposCartas t) {
		this.setHorizontalAlignment(CENTER);
		this.setVerticalAlignment(CENTER);
		this.tipo = t;
		ImageIcon img;
		switch (t) {
		case SAIR_PELA_TANGENTE:
			img = new ImageIcon("sair_pela_tangente.png");
			// Configurar descrição da carta
			break;
		case CORREDORES_EXPERIENTES:
			img = new ImageIcon("corredores_experientes.png");
			// Configurar descrição da carta
			break;
		case ESCUDOS:
			img = new ImageIcon("escudos.png");
			// Configurar descrição da carta
			break;
		case ESPIAR:
			img = new ImageIcon("espiar.png");
			// Configurar descrição da carta
			break;
		case MAOS_AO_ALTO:
			img = new ImageIcon("maos_ao_alto.png");
			// Configurar descrição da carta
			break;
		case MOVIMENTO_BRUSCO:
			img = new ImageIcon("movimento_brusco.png");
			// Configurar descrição da carta
			break;
		case RECICLAGEM:
			img = new ImageIcon("reciclagem.png");
			// Configurar descrição da carta
			break;
		case SACRIFICIO_NECESSARIO:
			img = new ImageIcon("sacrificio_necessario.png");
			// Configurar descrição da carta
			break;
		case SAVE_THE_KING:
			img = new ImageIcon("save_the_king.png");
			// Configurar descrição da carta
			break;
		case SILENCIO_POR_FAVOR:
			img = new ImageIcon("silencio_por_favor.png");
			// Configurar descrição da carta
			break;
		default:
			URL url = getClass().getResource("/backcard.png");
			img = new ImageIcon(url);
			this.setToolTipText("This is a default card, for testing purposes. If you use this card, not will actually happen.");
			break;
		}
		
		this.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				usarCarta();
			}
			
			@Override
			public void mouseEntered(MouseEvent e) {
				setBorder(BorderFactory.createLineBorder(new Color(0, 0, 0)));
			}
			
			@Override
			public void mouseExited(MouseEvent e) {
				setBorder(null);
			}
		});
		
		this.setIcon(img);
	}
	protected void usarCarta() {
		switch (this.tipo) {
		case CORREDORES_EXPERIENTES:
			break;
		case ESCUDOS:
			break;
		case ESPIAR:
			break;
		case MAOS_AO_ALTO:
			break;
		case MOVIMENTO_BRUSCO:
			break;
		case RECICLAGEM:
			break;
		case SACRIFICIO_NECESSARIO:
			break;
		case SAIR_PELA_TANGENTE:
			break;
		case SAVE_THE_KING:
			break;
		case SILENCIO_POR_FAVOR:
			break;
		case DEFAULT:
			JOptionPane.showMessageDialog(this, "Well, as I said, nothing happens.");
			break;
		}		
	}
	public TiposCartas getTipo() {
		return tipo;
	}
}
