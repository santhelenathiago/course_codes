package InterfaceGrafica;

import java.awt.Color;
import java.awt.Dimension;

import javax.swing.JLabel;
import javax.swing.JPanel;
import net.miginfocom.swing.MigLayout;

public class InformacoesDeJogador extends PanelArredondado {
	private JLabel nome;
	private JLabel cartasDeck;
	private JLabel cartasMao;
	private JLabel cartasDescarte;
	
	public InformacoesDeJogador( ) {
		this.setBackground(new Color(255, 255, 255));
		this.setPreferredSize(new Dimension(170, 100));
		this.
		
		nome = new JLabel();
		cartasDeck = new JLabel();
		cartasMao = new JLabel();
		cartasDescarte = new JLabel();

		setLayout(new MigLayout("", "[71px][]", "[15px][][][][]"));

		this.add(nome, "cell 0 0");
		
		add(new JLabel("Mão:"), "cell 0 1");
		this.add(cartasMao, "cell 1 1");
		
		add(new JLabel("Deck:"), "cell 0 2");
		this.add(cartasDeck, "cell 1 2");
		
		add(new JLabel("Descarte:"), "cell 0 3");
		this.add(cartasDescarte, "cell 1 3");


	}
	
	public String getNome() {
		return nome.getText();
	}

	public void setNome(String nome) {
		this.nome.setText(nome);
	}

	public int getCartasDeck() {
		return Integer.parseInt(cartasDeck.getText());
	}

	public void setCartasDeck(int cartasDeck) {
		this.cartasDeck.setText("" + cartasDeck);
	}

	public int getCartasMao() {
		return Integer.parseInt(cartasMao.getText());
	}

	public void setCartasMao(int cartasMao) {
		this.cartasMao.setText("" + cartasMao);
	}

	public int getCartasDescarte() {
		return Integer.parseInt(cartasDescarte.getText());
	}

	public void setCartasDescarte(int cartasDescarte) {
		this.cartasDescarte.setText("" + cartasDescarte);
	}
}
