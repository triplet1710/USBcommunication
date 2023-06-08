using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.VisualBasic.PowerPacks;
using UsbLibrary;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        bool[] DO = new bool[4] { false, false, false, false };
        Button[] ledbtn = new Button[4];
        RectangleShape[] led = new RectangleShape[4];
        byte[] readbuff = new byte[6];
        byte[] writebuff = new byte[6];
    public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
         
            RectangleShape[] tmp2 = new RectangleShape[4] { rectangleShape1, rectangleShape2, rectangleShape3, rectangleShape4 };
            Button[] tmp1 = new Button[4] { btn1, btn2, btn3, btn4 };
            ledbtn = tmp1;
            led = tmp2;
            usbHidPort.VendorId = 0x04D8;
            usbHidPort.ProductId = 0x0007;    
            usbHidPort.CheckDevicePresent();
        }

        private void usbHidPort_OnDataRecieved(object sender, DataRecievedEventArgs args)
        {
            if (InvokeRequired)
            {
                try
                {
                    Invoke(new DataRecievedEventHandler(usbHidPort_OnDataRecieved), new object[] { sender, args });
                }
                catch { }

            }
            else
            {
                if (usbHidPort.SpecifiedDevice != null)
                {
                    readbuff = args.data;
                    if (readbuff[1] == '&' )
                    {
                        for (int i = 0; i < 4; i++)
                        {
                            if (readbuff[i+2] == '1')
                            {   
                                if (DO[i] == false)
                                {
                                    led[i].FillColor = Color.Red;
                                    DO[i] = true;
                                }
                                else
                                {
                                    led[i].FillColor = Color.White;
                                    DO[i] = false;
                                }
                            }
                            
                        }
                    }
                    else if (readbuff[1] == '*')
                    {
                        for (int i = 0; i < 4; i++)
                        {
                            if (readbuff[i + 2] == 'S')
                            {
                                ledbtn[i].BackColor = Color.Yellow;
                            }
                            else if (readbuff[i + 2] == 'T')
                            {
                                ledbtn[i].BackColor = Color.LightGray;
                            }
                        }
                    }
                }
            }
        }

        private void usbHidPort_OnSpecifiedDeviceArrived(object sender, EventArgs e)
        {
            textBox1.Text = "Connected";
            textBox1.BackColor = Color.Lime;
            

        }

        private void usbHidPort_OnSpecifiedDeviceRemoved(object sender, EventArgs e)
        {
            if (InvokeRequired)
            {
                Invoke(new EventHandler(usbHidPort_OnSpecifiedDeviceRemoved), new object[] { sender, e });
            }
            else
            {
                textBox1.Text = "Disconnected";
                textBox1.BackColor = Color.Red;
                
            }
        }   

        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            usbHidPort.RegisterHandle(Handle);
        }
        protected override void WndProc(ref Message m)
        {
            usbHidPort.ParseMessages(ref m);
            base.WndProc(ref m);
        }


        private void button2_Click(object sender, EventArgs e)
        {
            if (usbHidPort.SpecifiedDevice != null)
            {
                writebuff[1] = (byte)'B';
                for (int i = 0; i < 4; i++)
                    writebuff[i+2] = (byte)'#'; 
                writebuff[2] = (byte)'@';
                usbHidPort.SpecifiedDevice.SendData(writebuff);  
            }
            else
            {   
                MessageBox.Show("device not found");
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void groupBox3_Enter(object sender, EventArgs e)
        {

        }

        private void btn2_Click(object sender, EventArgs e)
        {
            if (usbHidPort.SpecifiedDevice != null)
            {
                writebuff[1] = (byte)'B';
                for (int i = 0; i < 4; i++)
                    writebuff[i + 2] = (byte)'#';
                writebuff[3] = (byte)'@';
                usbHidPort.SpecifiedDevice.SendData(writebuff);
            }
            else
            {
                MessageBox.Show("device not found");
            }
        }

        private void btn3_Click(object sender, EventArgs e)
        {
            if (usbHidPort.SpecifiedDevice != null)
            {
                writebuff[1] = (byte)'B';
                for (int i = 0; i < 4; i++)
                    writebuff[i + 2] = (byte)'#';
                writebuff[4] = (byte)'@';
                usbHidPort.SpecifiedDevice.SendData(writebuff);
            }
            else
            {
                MessageBox.Show("device not found");
            }
        }

        private void btn4_Click(object sender, EventArgs e)
        {
            if (usbHidPort.SpecifiedDevice != null)
            {
                writebuff[1] = (byte)'B';
                for (int i = 0; i < 4; i++)
                    writebuff[i + 2] = (byte)'#';
                writebuff[5] = (byte)'@';
                usbHidPort.SpecifiedDevice.SendData(writebuff);
            }
            else
            {
                MessageBox.Show("device not found");
            }
        }

        
    }
}
