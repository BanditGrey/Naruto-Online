package Processors.Game.Lobby.OhtsutsukiKaguya.CellMc
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNightPowerPrivilege;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TPSixOne
   {
      
      protected var ThisPanel:MovieClip = null;
      
      protected var FBitmMap_Image:MovieClip = null;
      
      protected var FTF_Count:TextField = null;
      
      protected var FMC_Price:TextField = null;
      
      protected var FTF_Dec:TextField = null;
      
      protected var FMC_Buff1:MovieClip = null;
      
      protected var FMC_Buff2:MovieClip = null;
      
      protected var FMC_Expect:MovieClip = null;
      
      protected var FMC_Horizontal_Line:MovieClip = null;
      
      protected var FTF_GoodsName:TextField = null;
      
      protected var FCurDate:TNightPowerPrivilege = null;
      
      protected var FBmP:Bitmap;
      
      protected var FImangeId:uint = 0;
      
      public function TPSixOne()
      {
         super();
         this.FBmP = new Bitmap();
      }
      
      public function SetThisPanel(param1:MovieClip) : void
      {
         this.ThisPanel = param1;
         this.Initilization();
      }
      
      public function get Thispanel() : MovieClip
      {
         return this.ThisPanel;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this.ThisPanel.visible = param1;
      }
      
      protected function Initilization() : void
      {
         this.FBitmMap_Image = this.ThisPanel["MC_Slot"]["MC_Bmp_Icon"];
         this.FTF_Count = this.ThisPanel["MC_Slot"]["TF_Count"];
         this.FTF_Count.visible = false;
         this.FMC_Buff2 = this.ThisPanel["MC_Buff2"];
         this.FMC_Buff1 = this.ThisPanel["MC_Buff1"];
         this.FBitmMap_Image.addChild(this.FBmP);
         this.FMC_Price = this.ThisPanel["MC_Price"]["TF_OriginalPrice"];
         this.FTF_Dec = this.ThisPanel["MC_Price"]["TF_dec"];
         this.FMC_Expect = this.ThisPanel["MC_Expect"];
         this.FTF_GoodsName = this.ThisPanel["TF_GoodsName"];
         this.FMC_Horizontal_Line = this.ThisPanel["MC_Price"]["MC_Horizontal_Line"];
         this.FMC_Horizontal_Line.visible = false;
      }
      
      public function set CurDate(param1:TNightPowerPrivilege) : void
      {
         this.FCurDate = param1;
         this.Update();
      }
      
      public function get CurDate() : TNightPowerPrivilege
      {
         return this.FCurDate;
      }
      
      public function Update() : void
      {
         this.FTF_Dec.text = this.FCurDate.Description;
         this.FTF_GoodsName.text = this.FCurDate.Name;
         this.FMC_Price.text = String(this.FCurDate.Price);
         this.FImangeId = this.FCurDate.Icon;
         if(this.FCurDate.IsHold)
         {
            this.FMC_Expect.visible = true;
         }
         else
         {
            this.FMC_Expect.visible = false;
         }
         this.Update_Buff();
      }
      
      public function Update_Buff() : void
      {
         if(SLogicsCore.KaguyaData.CurLevel >= this.FCurDate.Needlevel)
         {
            this.FMC_Buff1.visible = true;
            this.FMC_Buff2.visible = false;
         }
         else
         {
            this.FMC_Buff1.visible = false;
            this.FMC_Buff2.visible = true;
            this.FMC_Buff2.TF_Buff.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.Lv_Open,this.FCurDate.Needlevel);
         }
      }
      
      public function UpdateImage() : void
      {
         if(!this.FImangeId)
         {
            return;
         }
         if(!this.ThisPanel.visible)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_NightPower,this.FBmP,CONST_MODULES.MODULE_Kaguya,this.FImangeId);
      }
      
      public function set ImangeId(param1:uint) : void
      {
         this.FImangeId = param1;
      }
      
      public function get ImangeId() : uint
      {
         return this.FImangeId;
      }
   }
}

