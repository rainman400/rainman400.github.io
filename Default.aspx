<%@ Page Title="BC Lottery Calculator" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="codeChallenge2._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script runat="server">

        private List<int> numbers = new List<int>();
        void ValidateBtn_OnClick(object sender, EventArgs e)
        {
            TextboxForAnswer.Text = "";
            if (Page.IsValid && DuplicateValidation())
            {
                int totalWin = 0;
                int totalSpend = 0;
                //Go through each lottery winning number combination
                for(int i = 0; i < lotteryDetails.Count; i++)
                {
                    float matchCount = 0;
                    bool bonusMatch = false;
                    //Verify how many, if any, numbers matched, including bonus number
                    for(int j = 0; j < numbers.Count; j++)
                    {
                        if(lotteryDetails[i].winningNumbers.Contains(numbers[j]))
                        {
                            matchCount++;
                        }
                        if(numbers[j] == lotteryDetails[i].bonusNumber)
                        {
                            bonusMatch = true;
                        }
                        if(lotteryDetails[i].drawNumber < 2125)
                        {
                            totalSpend += 1;
                        }
                        else if(lotteryDetails[i].drawNumber < 2990)
                        {
                            totalSpend += 2;
                        }
                        else
                        {
                            totalSpend += 3;
                        }
                    }

                    if(matchCount > 3)
                    {
                        if(matchCount == 5 && bonusMatch)
                        {
                            matchCount += 0.5f;
                        }
                        TextboxForAnswer.Text += lotteryDetails[i].date.ToString("dd/MM/yyyy") + " won: $" + String.Format("{0:0,0.0}",winnings[matchCount]) +"\n";
                        totalWin += winnings[matchCount];
                    }
                }
                TextboxForAnswer.Text += "---------\n";
                TextboxForAnswer.Text += "Total Won: $" + String.Format("{0:0,0.0}",totalWin)+"\n";
                TextboxForAnswer.Text += "You Spent: $" + String.Format("{0:0,0.0}",totalSpend)+"\n";
                var difference = totalWin - totalSpend;
                TextboxForAnswer.Text += "Net won/loss: $" + String.Format("{0:0,0.0}", (difference < 0? "("+Math.Abs(difference).ToString()+")":difference.ToString()))+"\n";
            }

            else
            {
                TextboxForAnswer.Text += "Please fix errors and try again!";
            }

        }

        void NumberValidation(object source, ServerValidateEventArgs args)
        {
            try
            {
                int i = int.Parse(args.Value);
                args.IsValid = (i>=0 && i<=49);
            }

            catch(Exception ex)
            {
                args.IsValid = false;
            }

        }

        bool DuplicateValidation()
        {
            foreach(TextBox tBox in textboxes)
            {
                var boxNumber = Convert.ToInt32(tBox.Text);
                if(!numbers.Contains(boxNumber))
                {
                    numbers.Add(boxNumber);
                }
                else
                {
                    TextboxForAnswer.Text += "Duplicate Numbers! Too many "+boxNumber.ToString()+". Remove the one at box #"+textboxes.IndexOf(tBox)+1+  "?\n\n";
                    return false;
                }
            }
            return true;
        }

   </script>    
    <div >
        <h1>Welcome to the Code Challenge Solution</h1>
        <p>Enter six numbers (between 1 and 49) below and we will check them against every 6/49 draw since 1981, and calculate your net winnings (or losings)</p>

        <div style="height: 416px">
            <div style="height: 113px; width: 70px" class = "displayInline">
                <asp:TextBox ID="TextBox1" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator1" runat="server"  ControlToValidate="TextBox1" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation"></asp:CustomValidator>
            </div>
            <div style="height: 113px; width: 70px"class = "displayInline">
                <asp:TextBox ID="TextBox2" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="TextBox2" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation"></asp:CustomValidator>
            </div><div style="height: 113px; width: 70px"class = "displayInline">
                <asp:TextBox ID="TextBox3" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator3" runat="server" ControlToValidate="TextBox3" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation"></asp:CustomValidator>
            </div><div style="height: 113px; width: 70px"class = "displayInline">
                <asp:TextBox ID="TextBox4" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator4" runat="server" ControlToValidate="TextBox4" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation"></asp:CustomValidator>
            </div><div style="height: 113px; width: 70px"class = "displayInline">
                <asp:TextBox ID="TextBox5" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator5" runat="server" ControlToValidate="TextBox5" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation"></asp:CustomValidator>
            </div><div style="height: 113px; width: 70px"class = "displayInline">
                <asp:TextBox ID="TextBox6" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator6" runat="server" ControlToValidate="TextBox6" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation"></asp:CustomValidator>
            </div>





    <div>

       <asp:Button id="Button1" runat="server" Text="Click To Check now!" OnClick="ValidateBtn_OnClick" />

        <div style="height: 198px">
            <asp:Textbox ID="TextboxForAnswer" runat="server" Text=" " Height="279px" ReadOnly="True" TextMode="MultiLine" Width="425px"></asp:Textbox>
        </div>

    </div>

        </div>





    </div>
</asp:Content>
