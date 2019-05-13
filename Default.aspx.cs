using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace codeChallenge2
{
    public partial class _Default : Page
    {
        public struct LotteryDetails
        {
            public int drawNumber;
            //public int seqNumber;
            public DateTime date;
            public List<int> winningNumbers;
            public int bonusNumber;
        }
 

        public List<LotteryDetails> lotteryDetails = new List<LotteryDetails>();
        public List<TextBox> textboxes = new List<TextBox>();
        public Dictionary<float, int> winnings = new Dictionary<float, int>()
        {
            { 4,85 },
            { 5,3000 },
            { 5.5f,250000 },
            { 6,5000000 },
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] str = File.ReadAllLines(Server.MapPath("649.csv"));
            
            for (int i = 1; i < str.Length; i++)
            {
                string[] temp = str[i].Split(',');
                if (Convert.ToInt32(temp[2]) == 0)
                {
                    var tempLotteryDeets = new LotteryDetails
                    {
                        drawNumber = Convert.ToInt32(temp[1]),
                        date = DateTime.Parse(temp[3].Replace("\"", "")),
                        winningNumbers = new List<int>() { Convert.ToInt32(temp[4]), Convert.ToInt32(temp[5]), Convert.ToInt32(temp[6]), Convert.ToInt32(temp[7]), Convert.ToInt32(temp[8]), Convert.ToInt32(temp[9])},
                        bonusNumber = Convert.ToInt32(temp[10])
                    };
                    lotteryDetails.Add(tempLotteryDeets);
                    
                }

            }
            textboxes = new List<TextBox>() { TextBox1, TextBox2, TextBox3, TextBox4, TextBox5, TextBox6 };

        }



    }
}