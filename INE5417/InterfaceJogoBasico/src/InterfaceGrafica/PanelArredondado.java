package InterfaceGrafica;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;

import javax.swing.JPanel;

public class PanelArredondado extends JPanel {
    protected Dimension arcs = new Dimension(20, 20);

	public PanelArredondado() {
		super();
		this.setBackground(new Color(200, 200, 200));
		setOpaque(false);
	}
	
	@Override
	protected void paintComponent(Graphics g) {
		super.paintComponent(g);
		int width = getWidth();
		int height = getHeight();
		
		Graphics2D graphics = (Graphics2D) g;
		
		graphics.setColor(getBackground());
		graphics.fillRoundRect(0, 0, width, height, arcs.width, arcs.height);
		graphics.setColor(getForeground());
	}
}
