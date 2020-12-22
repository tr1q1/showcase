package forms;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.Border;
import javax.swing.border.EmptyBorder;

import data.Config;
import data.LogServicio;

public class FrmLogin extends JFrame {
	
	public FrmLogin(){
		
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);		
		
		// Ventana
		this.setMinimumSize(new Dimension(300, 200));
		this.setLayout(new BoxLayout(this.getContentPane(), BoxLayout.PAGE_AXIS));		
		
		// Titulo
		JLabel lbTitulo = new JLabel("Servicios de EINSA - Login",JLabel.CENTER);		
		lbTitulo.setFont(new Font(lbTitulo.getFont().getName(), Font.BOLD, 16));
		lbTitulo.setBorder(BorderFactory.createEmptyBorder(15,15,15,15));
		lbTitulo.setAlignmentX(CENTER_ALIGNMENT);
		this.add(lbTitulo);

		// form
		JPanel pnForm = new JPanel(new GridLayout(0, 2, 3, 3));
		pnForm.setBorder(new EmptyBorder(15, 15, 15, 15));
		
		pnForm.add(new JLabel("Usuario"));
		JTextField txtUser = new JTextField("EAN\\");
		pnForm.add(txtUser);
		
		pnForm.add(new JLabel("Contraseña"));
		JPasswordField txtContrasena = new JPasswordField();
		pnForm.add(txtContrasena);
		
		JButton btAceptar = new JButton("Aceptar");
		JButton btCancelar = new JButton("Cancelar");
		pnForm.add(btAceptar);
		pnForm.add(btCancelar);
		
		this.add(pnForm);
		
		txtUser.requestFocus();
		txtUser.select(txtUser.getText().length(), txtUser.getText().length() );
		
		btAceptar.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				Config.ususarioBaseDatos = txtUser.getText();
				Config.contrasenaBaseDatos = txtContrasena.getPassword().toString();
				FrmLogin.getFrames()[0].dispose();
				new FrmMain();
			}
		});
		
		
		// Mostramos pantalla
		pack();
		this.setLocationRelativeTo(null);		
		this.setVisible(true);
		
	}
	

}
