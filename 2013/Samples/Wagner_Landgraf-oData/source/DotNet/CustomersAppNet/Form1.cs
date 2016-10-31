using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.Services.Client;


namespace CustomersAppNet
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private DataServiceContext service;

        private void Form1_Load(object sender, EventArgs e)
        {
            service = new DataServiceContext(new Uri(@"http://localhost:2001/tms/entities"));
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var customers = service.CreateQuery<TContact>("TContact");
            var customersByName = from c in customers
                                  orderby c.FName descending
                                  where (c.FId <= 1) || (c.FName == "Hugo")
                                  select c;
            dataGridView1.DataSource = customersByName.ToList();
        }
    }

    public class TContact
    {
        public int FId { get; set; }
        public string FName { get; set; }
        public string FPhone { get; set; }
    }

    public class TCustomer
    {
        public int FId { get; set; }
        public string FName { get; set; }
        public string FCity { get; set; }
        public string FState { get; set; }
    }
}
