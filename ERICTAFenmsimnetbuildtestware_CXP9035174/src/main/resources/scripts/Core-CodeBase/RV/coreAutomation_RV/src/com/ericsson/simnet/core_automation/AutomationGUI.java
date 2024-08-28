/*------------------------------------------------------------------------------
 *******************************************************************************
 * COPYRIGHT Ericsson 2012
 *
 * The copyright to the computer program(s) herein is the property of
 * Ericsson Inc. The programs may be used and/or copied only with written
 * permission from Ericsson Inc. or in accordance with the terms and
 * conditions stipulated in the agreement/contract under which the
 * program(s) have been supplied.
 *******************************************************************************
 *----------------------------------------------------------------------------*/
package com.ericsson.simnet.core_automation;

import java.awt.EventQueue;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.JRadioButton;
import javax.swing.ButtonGroup;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

//import com.jgoodies.forms.factories.DefaultComponentFactory;
import java.awt.Font;

import javax.swing.JPasswordField;
import javax.swing.JButton;

import java.awt.Color;
import java.io.IOException;
import java.net.UnknownHostException;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;
import com.jgoodies.forms.factories.DefaultComponentFactory;

public class AutomationGUI {

	private JFrame frame;
	private JTextField textSimName;
	private JTextField textNodeType;
	private JTextField textDD;
	private JTextField textNumOfNodes;
	private JTextField textNumofMosOfNode;
	private JTextField textFTPAddress;
	private JTextField textDDPath;
	private JTextField textUserName;
	private JPasswordField nexusPassword;
	private JTextField textVersion;
	private JTextField txt_classifier;

	// JButton btnGenerateConfig = new JButton("Generate Config");

	private final ButtonGroup btn_ARNE = new ButtonGroup();
	private final ButtonGroup btn_MOs = new ButtonGroup();
	private final ButtonGroup btn_FTP = new ButtonGroup();
	private final ButtonGroup btn_NEXUS = new ButtonGroup();
	private final ButtonGroup btn_MO_struct = new ButtonGroup();

	JRadioButton rdbtnArneYes = new JRadioButton("Yes");
	JRadioButton rdbtnArneNo = new JRadioButton("No");
	JRadioButton rdbtnMOsYes = new JRadioButton("Yes");
	JRadioButton rdbtnMOsNo = new JRadioButton("No");
	JRadioButton rdbtnsendSimFTPYes = new JRadioButton("Yes");
	JRadioButton rdbtnsendSimFTPNo = new JRadioButton("No");
	JRadioButton rdbtnsendSIMNEXSUSYes = new JRadioButton("Yes");
	JRadioButton rdbtnsendSIMNEXSUSNo = new JRadioButton("No");
	JRadioButton radioButton_MO_struct_Yes = new JRadioButton("Yes");
	JRadioButton radioButton_MO_struct_No = new JRadioButton("No");
	JButton btnGenerateConfig = new JButton("Generate Config");

	String SIM_Name, NODE_Type, Base_Name, DEFAULT_Destination,
			str_NO_of_Nodes, str_NO_of_MOs_Node, str_NO_of_diff_MOs_Node,
			MIM_Name, FTP_Address, FTP_Destination_Path, NEXUS_User_Name,
			NEXUS_Password, NEXUS_Version, NEXUS_classifier;
	int NO_of_Nodes, NO_of_MOs, NO_of_diff_MOs;
	boolean Simulation_Available, mim_file_available, Arne_Required = false,
			MOs_Required = false, MOs_struct_defined = false,
			send_sim_to_FTP_required = false,
			send_sim_to_NEXUS_required = false;
	private JTextField txt_Base_Name;

	private JTextField txt_No_of_diff_MOs;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) throws UnknownHostException,
			IOException, InterruptedException {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					AutomationGUI window = new AutomationGUI();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public AutomationGUI() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 470, 586);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		frame.setTitle("Automation");

		JLabel lblAutomationOfSimulations = DefaultComponentFactory
				.getInstance().createTitle("Automation of Simulations");
		lblAutomationOfSimulations.setForeground(new Color(0, 0, 255));
		lblAutomationOfSimulations.setFont(new Font("Times New Roman",
				Font.BOLD | Font.ITALIC, 16));
		lblAutomationOfSimulations.setBounds(86, 11, 245, 18);
		frame.getContentPane().add(lblAutomationOfSimulations);

		JLabel lblSimulationName = new JLabel("Simulation Name");
		lblSimulationName.setForeground(Color.BLUE);
		lblSimulationName.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblSimulationName.setBounds(10, 50, 100, 20);
		frame.getContentPane().add(lblSimulationName);

		textSimName = new JTextField();
		textSimName.setBounds(200, 50, 175, 20);
		frame.getContentPane().add(textSimName);
		textSimName.setColumns(10);

		JLabel lblNodeType = new JLabel("Node_Type");
		lblNodeType.setForeground(Color.BLUE);
		lblNodeType.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblNodeType.setBounds(10, 75, 118, 20);
		frame.getContentPane().add(lblNodeType);

		textNodeType = new JTextField();
		textNodeType.addFocusListener(new FocusAdapter() {
			@Override
			public void focusLost(FocusEvent e) {
				String NE_Type = textNodeType.getText();
				NE_Type = NE_Type.trim();

				String NE_Name = NE_Type.replaceAll("\\s", "-");
				txt_Base_Name.setText(NE_Name);
			}
		});
		textNodeType.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		textNodeType.setBounds(200, 75, 174, 20);
		frame.getContentPane().add(textNodeType);
		textNodeType.setColumns(10);

		JLabel lbl_Base_Name = new JLabel("Base Name");
		lbl_Base_Name.setForeground(Color.BLUE);
		lbl_Base_Name.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lbl_Base_Name.setBounds(10, 100, 100, 20);
		frame.getContentPane().add(lbl_Base_Name);

		txt_Base_Name = new JTextField();
		txt_Base_Name.setBounds(200, 100, 175, 20);
		frame.getContentPane().add(txt_Base_Name);
		txt_Base_Name.setColumns(10);

		JLabel lblNoOfNodes = new JLabel("No of Nodes");
		lblNoOfNodes.setForeground(Color.BLUE);
		lblNoOfNodes.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblNoOfNodes.setBounds(10, 125, 133, 20);
		frame.getContentPane().add(lblNoOfNodes);

		textNumOfNodes = new JTextField();
		textNumOfNodes.setBounds(200, 125, 174, 20);
		textNumOfNodes.setText("4");
		frame.getContentPane().add(textNumOfNodes);
		textNumOfNodes.setColumns(10);

		JLabel lblDefaultDestination = new JLabel("Default Destination");
		lblDefaultDestination.setForeground(Color.BLUE);
		lblDefaultDestination.setFont(new Font("Times New Roman", Font.PLAIN,
				12));
		lblDefaultDestination.setBounds(10, 150, 125, 20);
		frame.getContentPane().add(lblDefaultDestination);

		textDD = new JTextField();
		textDD.setBounds(200, 150, 174, 20);
		textDD.setText("192.168.0.12");
		frame.getContentPane().add(textDD);
		textDD.setColumns(10);

		JLabel lblArneRequired = new JLabel("ARNE Required");
		lblArneRequired.setForeground(Color.BLUE);
		lblArneRequired.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblArneRequired.setBounds(10, 175, 103, 20);
		frame.getContentPane().add(lblArneRequired);

		btn_ARNE.add(rdbtnArneYes);
		rdbtnArneYes.setForeground(Color.BLACK);
		rdbtnArneYes.setBounds(200, 175, 56, 20);
		frame.getContentPane().add(rdbtnArneYes);

		btn_ARNE.add(rdbtnArneNo);
		rdbtnArneNo.setSelected(true);
		rdbtnArneNo.setBounds(274, 175, 50, 20);
		frame.getContentPane().add(rdbtnArneNo);

		JLabel lblMoScaleUp = new JLabel("MO scale up Required");
		lblMoScaleUp.setForeground(Color.BLUE);
		lblMoScaleUp.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblMoScaleUp.setBounds(10, 200, 133, 20);
		frame.getContentPane().add(lblMoScaleUp);

		btnGenerateConfig.setEnabled(false);
		btnGenerateConfig.setFont(new Font("Times New Roman", Font.BOLD, 12));
		btnGenerateConfig.setForeground(Color.BLACK);

		rdbtnMOsYes.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				// txt_No_of_MOs_Node.setEditable(true);
				// txt_No_of_diff_MOs.setEditable(true);
				radioButton_MO_struct_Yes.setEnabled(true);
				radioButton_MO_struct_No.setEnabled(true);

			}
		});
		btn_MOs.add(rdbtnMOsYes);
		rdbtnMOsYes.setBounds(200, 200, 56, 20);
		frame.getContentPane().add(rdbtnMOsYes);
		rdbtnMOsNo.setSelected(true);

		rdbtnMOsNo.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				txt_No_of_diff_MOs.setEditable(false);
				textNumofMosOfNode.setEditable(false);
				txt_No_of_diff_MOs.setText("");
				textNumofMosOfNode.setText("");
				btn_MO_struct.clearSelection();
				radioButton_MO_struct_Yes.setEnabled(false);
				radioButton_MO_struct_No.setEnabled(false);
				btnGenerateConfig.setEnabled(false);
			}
		});
		btn_MOs.add(rdbtnMOsNo);
		rdbtnMOsNo.setBounds(274, 200, 50, 20);
		frame.getContentPane().add(rdbtnMOsNo);

		JLabel lblUserDefinedMos = new JLabel("User defined MOs");
		lblUserDefinedMos.setForeground(Color.BLUE);
		lblUserDefinedMos.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblUserDefinedMos.setBounds(10, 225, 100, 20);
		frame.getContentPane().add(lblUserDefinedMos);

		btn_MO_struct.add(radioButton_MO_struct_Yes);
		radioButton_MO_struct_Yes.setEnabled(false);
		radioButton_MO_struct_Yes.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				txt_No_of_diff_MOs.setEditable(true);
				textNumofMosOfNode.setEditable(false);
				textNumofMosOfNode.setText("");
				btnGenerateConfig.setEnabled(true);
			}
		});
		radioButton_MO_struct_Yes.setBounds(200, 225, 56, 20);
		frame.getContentPane().add(radioButton_MO_struct_Yes);

		btn_MO_struct.add(radioButton_MO_struct_No);
		radioButton_MO_struct_No.setEnabled(false);
		radioButton_MO_struct_No.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				txt_No_of_diff_MOs.setEditable(false);
				txt_No_of_diff_MOs.setText("");
				textNumofMosOfNode.setEditable(true);
				btnGenerateConfig.setEnabled(false);
			}
		});
		radioButton_MO_struct_No.setBounds(274, 225, 50, 20);
		frame.getContentPane().add(radioButton_MO_struct_No);

		JLabel lblNo_of_diff_MOs = new JLabel("No of different MOs");
		lblNo_of_diff_MOs.setForeground(Color.BLUE);
		lblNo_of_diff_MOs.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblNo_of_diff_MOs.setBounds(10, 250, 175, 20);
		frame.getContentPane().add(lblNo_of_diff_MOs);

		txt_No_of_diff_MOs = new JTextField();
		/*
		 * txt_No_of_diff_MOs.addFocusListener(new FocusAdapter() {
		 * 
		 * @Override public void focusLost(FocusEvent e) { String
		 * diff_MOs=txt_No_of_diff_MOs.getText(); int
		 * No_of_diff_MOs=Integer.parseInt(diff_MOs); Write_MOs_Data write=new
		 * Write_MOs_Data(); write.Write_MOs_to_config(No_of_diff_MOs);
		 * 
		 * JOptionPane.showMessageDialog(null,
		 * "Update all MOs and MOscount you want for that MO in the file \"MOs_Config.properties\" generated before submitting"
		 * , " MOs to be written", JOptionPane.INFORMATION_MESSAGE);
		 * 
		 * } });
		 */
		txt_No_of_diff_MOs.setEditable(false);
		txt_No_of_diff_MOs.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		txt_No_of_diff_MOs.setBounds(200, 250, 89, 20);
		frame.getContentPane().add(txt_No_of_diff_MOs);
		txt_No_of_diff_MOs.setColumns(10);

		JLabel lblNoOfMosnode = new JLabel("No of MOs/Node");
		lblNoOfMosnode.setForeground(Color.BLUE);
		lblNoOfMosnode.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblNoOfMosnode.setBounds(10, 275, 103, 20);
		frame.getContentPane().add(lblNoOfMosnode);

		textNumofMosOfNode = new JTextField();
		textNumofMosOfNode.setEditable(false);
		textNumofMosOfNode.setBounds(200, 275, 174, 20);
		frame.getContentPane().add(textNumofMosOfNode);
		textNumofMosOfNode.setColumns(10);

		JLabel lblSendSimToFTP = new JLabel("send Simulation to FTP");
		lblSendSimToFTP.setForeground(Color.BLUE);
		lblSendSimToFTP.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblSendSimToFTP.setBounds(10, 300, 200, 20);
		frame.getContentPane().add(lblSendSimToFTP);

		rdbtnsendSimFTPYes.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				textFTPAddress.setEditable(true);
				textDDPath.setEditable(true);
				textFTPAddress.setText("159.107.220.96");
				textDDPath.setText("/sims/");
			}
		});
		btn_FTP.add(rdbtnsendSimFTPYes);
		rdbtnsendSimFTPYes.setBounds(200, 300, 56, 20);
		frame.getContentPane().add(rdbtnsendSimFTPYes);
		rdbtnsendSimFTPNo.setSelected(true);

		rdbtnsendSimFTPNo.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				textFTPAddress.setEditable(false);
				textDDPath.setEditable(false);
				textFTPAddress.setText("");
				textDDPath.setText("");
			}
		});
		btn_FTP.add(rdbtnsendSimFTPNo);
		rdbtnsendSimFTPNo.setBounds(274, 300, 67, 20);
		frame.getContentPane().add(rdbtnsendSimFTPNo);

		JLabel lblFtpAddress = new JLabel("FTP Address");
		lblFtpAddress.setForeground(Color.BLUE);
		lblFtpAddress.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblFtpAddress.setBounds(10, 325, 112, 20);
		frame.getContentPane().add(lblFtpAddress);

		textFTPAddress = new JTextField();

		textFTPAddress.setEditable(false);
		textFTPAddress.setBounds(200, 325, 174, 20);
		frame.getContentPane().add(textFTPAddress);
		textFTPAddress.setColumns(10);

		JLabel lblDestinationPath = new JLabel("Destination Path");
		lblDestinationPath.setForeground(Color.BLUE);
		lblDestinationPath.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblDestinationPath.setBounds(10, 350, 112, 20);
		frame.getContentPane().add(lblDestinationPath);

		textDDPath = new JTextField();
		textDDPath.setEditable(false);
		textDDPath.setBounds(200, 350, 174, 20);
		frame.getContentPane().add(textDDPath);
		textDDPath.setColumns(10);

		JLabel lblsendSimToNEXUS = new JLabel("send Simulation to NEXUS");
		lblsendSimToNEXUS.setForeground(Color.BLUE);
		lblsendSimToNEXUS.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblsendSimToNEXUS.setBounds(10, 375, 200, 20);
		frame.getContentPane().add(lblsendSimToNEXUS);

		rdbtnsendSIMNEXSUSYes.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				textUserName.setEditable(true);
				nexusPassword.setEditable(true);
				textVersion.setEditable(true);
				txt_classifier.setEditable(true);
			}
		});
		btn_NEXUS.add(rdbtnsendSIMNEXSUSYes);
		rdbtnsendSIMNEXSUSYes.setBounds(200, 375, 56, 20);
		frame.getContentPane().add(rdbtnsendSIMNEXSUSYes);
		rdbtnsendSIMNEXSUSNo.setSelected(true);

		rdbtnsendSIMNEXSUSNo.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				textUserName.setEditable(false);
				nexusPassword.setEditable(false);
				textVersion.setEditable(false);
				txt_classifier.setEditable(false);
				textUserName.setText("");
				nexusPassword.setText("");
				textVersion.setText("");
				txt_classifier.setText("");
			}
		});
		btn_NEXUS.add(rdbtnsendSIMNEXSUSNo);
		rdbtnsendSIMNEXSUSNo.setBounds(274, 375, 50, 20);
		frame.getContentPane().add(rdbtnsendSIMNEXSUSNo);

		JLabel lblUserName = new JLabel("NEXUS UserName");
		lblUserName.setForeground(Color.BLUE);
		lblUserName.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblUserName.setBounds(10, 400, 133, 20);
		frame.getContentPane().add(lblUserName);

		textUserName = new JTextField();
		textUserName.setEditable(false);
		textUserName.setBounds(200, 400, 174, 20);
		frame.getContentPane().add(textUserName);
		textUserName.setColumns(10);

		JLabel lblPassword = new JLabel("NEXUS Password");
		lblPassword.setForeground(Color.BLUE);
		lblPassword.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblPassword.setBounds(10, 425, 118, 20);
		frame.getContentPane().add(lblPassword);

		nexusPassword = new JPasswordField();
		nexusPassword.setEditable(false);
		nexusPassword.setBounds(200, 425, 174, 20);
		frame.getContentPane().add(nexusPassword);

		JLabel lblVersion = new JLabel("Version");
		lblVersion.setForeground(Color.BLUE);
		lblVersion.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		lblVersion.setBounds(10, 450, 103, 20);
		frame.getContentPane().add(lblVersion);

		textVersion = new JTextField();
		textVersion.setEditable(false);
		textVersion.setBounds(200, 450, 174, 20);
		frame.getContentPane().add(textVersion);
		textVersion.setColumns(10);

		JLabel lblClassifier = new JLabel("Classifier");
		lblClassifier.setForeground(Color.BLUE);
		lblClassifier.setFont(new Font("Times New Roman", Font.PLAIN, 11));
		lblClassifier.setBounds(10, 475, 67, 20);
		frame.getContentPane().add(lblClassifier);

		txt_classifier = new JTextField();
		txt_classifier.setEditable(false);
		txt_classifier.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		txt_classifier.setBounds(200, 475, 174, 20);
		frame.getContentPane().add(txt_classifier);
		txt_classifier.setColumns(10);

		// String
		// SIM_Name,NODE_Type,DEFAULT_Destination,MIM_Name,FTP_Destination_Path,NEXUS_User_Name,NEXUS_Password,NEXUS_Version,NEXUS_classifier;
		// int NO_of_Nodes,NO_of_MOs;
		JButton btnSubmit = new JButton("SUBMIT");
		btnSubmit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				SIM_Name = textSimName.getText();
				SIM_Name = SIM_Name.trim();
				NODE_Type = textNodeType.getText();
				NODE_Type = NODE_Type.trim();
				Base_Name = txt_Base_Name.getText();
				Base_Name = Base_Name.trim();
				DEFAULT_Destination = textDD.getText();
				DEFAULT_Destination = DEFAULT_Destination.trim();
				str_NO_of_Nodes = textNumOfNodes.getText();

				check_File_in_Directory check_sim_name = new check_File_in_Directory();
				Simulation_Available = check_sim_name.check_file(SIM_Name,
						"/netsim/netsimdir");

				if (SIM_Name.contains(" ")) {

					JOptionPane.showMessageDialog(null,
							"The Simulation Name cannot contain spaces ",
							" error in Simulation Name",
							JOptionPane.ERROR_MESSAGE);
					textSimName.requestFocusInWindow();
				} else if (SIM_Name.equals("")) {

					JOptionPane.showMessageDialog(null,
							"The Simulation Name should not be empty ",
							" error in Simulation Name",
							JOptionPane.ERROR_MESSAGE);
					textSimName.requestFocusInWindow();
				} else if (Simulation_Available) {

					JOptionPane
							.showMessageDialog(
									null,
									"The simulation name you mentioned is already present in this installation",
									" error in Simulation Name",
									JOptionPane.ERROR_MESSAGE);
					textSimName.requestFocusInWindow();
				} else if (NODE_Type.equals("")) {

					JOptionPane.showMessageDialog(null,
							"The Node Type should not be empty ",
							" error in Node Type", JOptionPane.ERROR_MESSAGE);
					textNodeType.requestFocusInWindow();
				} else if (Base_Name.equals("")) {
					JOptionPane.showMessageDialog(null,
							"The Base Name should not be empty ",
							" error in Base Name", JOptionPane.ERROR_MESSAGE);
					textNodeType.requestFocusInWindow();
				} else if (Base_Name.contains(" ")) {
					JOptionPane.showMessageDialog(null,
							"The Base Name should not contain spaces ",
							" error in Base Name", JOptionPane.ERROR_MESSAGE);
					textNodeType.requestFocusInWindow();
				} else if (DEFAULT_Destination.equals("")) {

					JOptionPane.showMessageDialog(null,
							"The Default Destination should not be empty ",
							" error in Default_Destination",
							JOptionPane.ERROR_MESSAGE);
					textDD.requestFocusInWindow();
				} else if (str_NO_of_Nodes.equals("")) {

					JOptionPane.showMessageDialog(null,
							"No of Nodes should not be empty ",
							" error in No of Nodes", JOptionPane.ERROR_MESSAGE);
					textNumOfNodes.requestFocusInWindow();
				} else if (!(str_NO_of_Nodes.matches("[0-9]+"))) {

					JOptionPane.showMessageDialog(null,
							"No of Nodes should be a number ",
							" error in No of Nodes", JOptionPane.ERROR_MESSAGE);
					textNumOfNodes.requestFocusInWindow();
				} else if (!(rdbtnArneYes.isSelected())
						&& !(rdbtnArneNo.isSelected())) {

					JOptionPane.showMessageDialog(null,
							"Not specified whether ARNE Required or not ",
							" ARNE Required input not selected",
							JOptionPane.ERROR_MESSAGE);
					rdbtnArneYes.requestFocusInWindow();
				} else if (!(rdbtnMOsYes.isSelected())
						&& !(rdbtnMOsNo.isSelected())) {

					JOptionPane
							.showMessageDialog(
									null,
									"Not specified whether MO scale up Required or not ",
									" MO scale up input not selected",
									JOptionPane.ERROR_MESSAGE);
					rdbtnMOsYes.requestFocusInWindow();
				}

				else if ((rdbtnMOsYes.isSelected())
						&& !(radioButton_MO_struct_Yes.isSelected())
						&& !(radioButton_MO_struct_No.isSelected())) {

					JOptionPane
							.showMessageDialog(
									null,
									"Not specified whether User defined MOs or default ",
									" User defined MOs input not selected",
									JOptionPane.ERROR_MESSAGE);
					radioButton_MO_struct_No.requestFocusInWindow();
				}

				else if (!(rdbtnsendSimFTPYes.isSelected())
						&& !(rdbtnsendSimFTPNo.isSelected())) {

					JOptionPane
							.showMessageDialog(
									null,
									"Not specified whether Simulation must be sent to FTP or not ",
									" send Simulation to FTP input not selected",
									JOptionPane.ERROR_MESSAGE);
					rdbtnsendSimFTPYes.requestFocusInWindow();
				} else if (!(rdbtnsendSIMNEXSUSYes.isSelected())
						&& !(rdbtnsendSIMNEXSUSNo.isSelected())) {

					JOptionPane
							.showMessageDialog(
									null,
									"Not specified whether Simulation must be sent to NEXSUS or not ",
									" send Simulation to NEXUS input not selected",
									JOptionPane.ERROR_MESSAGE);
					rdbtnsendSIMNEXSUSYes.requestFocusInWindow();
				} else if (rdbtnMOsYes.isSelected()
						&& (radioButton_MO_struct_No.isSelected())
						&& (textNumofMosOfNode.getText().equals(""))) {

					JOptionPane.showMessageDialog(null,
							"The No of MOs/Node should not be empty ",
							" error in No of MOs/Node input",
							JOptionPane.ERROR_MESSAGE);
					textNumofMosOfNode.requestFocusInWindow();
				} else if (rdbtnMOsYes.isSelected()
						&& (radioButton_MO_struct_No.isSelected())
						&& (!(textNumofMosOfNode.getText().matches("[0-9]+")))) {

					JOptionPane.showMessageDialog(null,
							"The No of MOs/Node should be a number ",
							" error in No of MOs/Node input",
							JOptionPane.ERROR_MESSAGE);
					textNumofMosOfNode.requestFocusInWindow();
				} else if (rdbtnMOsYes.isSelected()
						&& (radioButton_MO_struct_Yes.isSelected())
						&& (txt_No_of_diff_MOs.getText().equals(""))) {

					JOptionPane.showMessageDialog(null,
							"The No of different MOs should not be empty ",
							" error in No of different MOs",
							JOptionPane.ERROR_MESSAGE);
					textNumofMosOfNode.requestFocusInWindow();
				} else if (rdbtnMOsYes.isSelected()
						&& (radioButton_MO_struct_Yes.isSelected())
						&& (!(txt_No_of_diff_MOs.getText().matches("[0-9]+")))) {

					JOptionPane.showMessageDialog(null,
							"The No of different MOs should be a number ",
							" error in No of different MOs",
							JOptionPane.ERROR_MESSAGE);
					textNumofMosOfNode.requestFocusInWindow();
				} else if (rdbtnsendSimFTPYes.isSelected()
						&& (textFTPAddress.getText().equals(""))) {

					JOptionPane.showMessageDialog(null,
							"The FTP Address should not be empty ",
							" error in FTP Address input",
							JOptionPane.ERROR_MESSAGE);
					textFTPAddress.requestFocusInWindow();
				} else if (rdbtnsendSimFTPYes.isSelected()
						&& (textDDPath.getText().equals(""))) {

					JOptionPane.showMessageDialog(null,
							"The FTP Destination path should not be empty ",
							" error in FTP Destinaton Path input",
							JOptionPane.ERROR_MESSAGE);
					textDDPath.requestFocusInWindow();
				} else if (rdbtnsendSIMNEXSUSYes.isSelected()
						&& (textUserName.getText().equals(""))) {

					JOptionPane.showMessageDialog(null,
							"The user name should not be empty ",
							" error in NEXUS user name input",
							JOptionPane.ERROR_MESSAGE);
					textUserName.requestFocusInWindow();
				} else if (rdbtnsendSIMNEXSUSYes.isSelected()
						&& (nexusPassword.getPassword().equals(""))) {

					JOptionPane.showMessageDialog(null,
							"The password should not be empty ",
							" error in NEXUS password input",
							JOptionPane.ERROR_MESSAGE);
					nexusPassword.requestFocusInWindow();
				} else if (rdbtnsendSIMNEXSUSYes.isSelected()
						&& (textVersion.getText().equals(""))) {

					JOptionPane.showMessageDialog(null,
							"The NEXUS version should not be empty ",
							" error in NEXUS version input",
							JOptionPane.ERROR_MESSAGE);
					textVersion.requestFocusInWindow();
				} else if (rdbtnsendSIMNEXSUSYes.isSelected()
						&& (txt_classifier.getText().equals(""))) {

					JOptionPane.showMessageDialog(null,
							"The NEXUS final input should not be empty ",
							" error in NEXUS final input",
							JOptionPane.ERROR_MESSAGE);
					txt_classifier.requestFocusInWindow();
				} else {
					// System.out.println("entered else loop");
					NO_of_Nodes = Integer.parseInt(str_NO_of_Nodes);

					if (rdbtnArneYes.isSelected())
						Arne_Required = true;
					if (rdbtnMOsYes.isSelected()) {
						MOs_Required = true;
						if (radioButton_MO_struct_No.isSelected()) {
							MOs_struct_defined = false;
							str_NO_of_MOs_Node = textNumofMosOfNode.getText();
							str_NO_of_MOs_Node = str_NO_of_MOs_Node.trim();
							NO_of_MOs = Integer.parseInt(str_NO_of_MOs_Node);
						} else {
							MOs_struct_defined = true;
							str_NO_of_diff_MOs_Node = txt_No_of_diff_MOs
									.getText();
							str_NO_of_diff_MOs_Node = str_NO_of_diff_MOs_Node
									.trim();
							NO_of_diff_MOs = Integer
									.parseInt(str_NO_of_diff_MOs_Node);
							// JOptionPane.showMessageDialog(null,
							// "Make sure that you had updated  MOs in the file \"MOs_Config.properties\" submitting",
							// " MOs to be written",
							// JOptionPane.INFORMATION_MESSAGE);

						}
					}
					if (rdbtnsendSimFTPYes.isSelected()) {
						FTP_Address = textFTPAddress.getText();
						FTP_Destination_Path = textDDPath.getText();
						send_sim_to_FTP_required = true;
					}
					if (rdbtnsendSIMNEXSUSYes.isSelected()) {
						NEXUS_User_Name = textUserName.getText();
						NEXUS_Password = new String(nexusPassword.getPassword());
						NEXUS_Version = textVersion.getText();
						NEXUS_classifier = txt_classifier.getText();
						send_sim_to_NEXUS_required = true;
					}

					frame.setVisible(false);
					// System.out.println("frame closed");

					start_Create_Simulation start_process = new start_Create_Simulation();
					try {

						start_process
								.Automation(SIM_Name, NODE_Type, Base_Name,
										DEFAULT_Destination, NO_of_Nodes,
										Arne_Required, MOs_Required,
										MOs_struct_defined,
										send_sim_to_FTP_required,
										send_sim_to_NEXUS_required, NO_of_MOs,
										NO_of_diff_MOs, FTP_Address,
										FTP_Destination_Path, NEXUS_User_Name,
										NEXUS_Password, NEXUS_Version,
										NEXUS_classifier);

						System.exit(0);
					}

					catch (UnknownHostException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				}
			}
		});
		btnSubmit.setFont(new Font("Times New Roman", Font.BOLD, 14));
		btnSubmit.setBounds(106, 517, 100, 25);
		frame.getContentPane().add(btnSubmit);

		JButton btnReset = new JButton("RESET");
		btnReset.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {

				textSimName.setText("");
				textNodeType.setText("");
				txt_Base_Name.setText("");
				textDD.setText("");
				textNumOfNodes.setText("");
				textNumofMosOfNode.setText("");
				textFTPAddress.setText("");
				textDDPath.setText("");
				textUserName.setText("");
				nexusPassword.setText("");
				textVersion.setText("");
				txt_classifier.setText("");

				btn_ARNE.clearSelection();
				btn_MOs.clearSelection();
				btn_FTP.clearSelection();
				btn_NEXUS.clearSelection();
			}
		});
		btnReset.setFont(new Font("Times New Roman", Font.BOLD, 14));
		btnReset.setBounds(231, 517, 100, 25);
		frame.getContentPane().add(btnReset);

		btnGenerateConfig.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String diff_MOs = txt_No_of_diff_MOs.getText();
				diff_MOs = diff_MOs.trim();
				if (diff_MOs.equals("")) {

					JOptionPane.showMessageDialog(null,
							"No of different MOs should not be empty ",
							" error in No of different MOs",
							JOptionPane.ERROR_MESSAGE);
					txt_No_of_diff_MOs.requestFocusInWindow();
				} else if (!(diff_MOs.matches("[0-9]+"))) {

					JOptionPane.showMessageDialog(null,
							"No of different MOs should be a number ",
							" error in No of different MOs",
							JOptionPane.ERROR_MESSAGE);
					txt_No_of_diff_MOs.requestFocusInWindow();
				} else {
					if (rdbtnMOsYes.isSelected()
							&& (!radioButton_MO_struct_No.isSelected())) {
						int No_of_diff_MOs = Integer.parseInt(diff_MOs);
						Write_MOs_Data write = new Write_MOs_Data();
						write.Write_MOs_to_config(No_of_diff_MOs);
						JOptionPane
								.showMessageDialog(
										null,
										"Update all MOs and count you want for that MO in the file \"MOs_Config.properties\" generated before submitting",
										" MOs to be written",
										JOptionPane.INFORMATION_MESSAGE);
					} else {
						if (!rdbtnMOsYes.isSelected()) {
							JOptionPane.showMessageDialog(null,
									"you have not selected MO scale up input ",
									" MO scale up input not selected",
									JOptionPane.ERROR_MESSAGE);
							rdbtnMOsYes.requestFocusInWindow();
						} else {
							JOptionPane.showMessageDialog(null,
									"you have not selected User defined MOs ",
									" User defined MOs input not selected",
									JOptionPane.ERROR_MESSAGE);
							radioButton_MO_struct_No.requestFocusInWindow();

						}
					}
				}
			}
		});
		btnGenerateConfig.setBounds(299, 249, 145, 20);
		frame.getContentPane().add(btnGenerateConfig);

	}
}