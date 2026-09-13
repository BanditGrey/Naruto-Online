package Processors.Game.Lobby.BloodFete.cell
{
   import Foundation.Utilities.TGameUtil;
   import Logics.BloodFete.TBloodFeteSingle;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TNumenCellMvc
   {
      
      protected var FT_Name:TextField = null;
      
      protected var FBT_Get:MovieClip = null;
      
      protected var FBT_Sell:MovieClip = null;
      
      protected var FMC_BloodFeteOne:MovieClip = null;
      
      protected var FBmp:Bitmap = null;
      
      protected var FIndex:int = 0;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FEffectId:uint = 0;
      
      protected var FBloodFeteDat:TBloodFeteSingle = null;
      
      protected var FSell_Sell_Func:Function = null;
      
      protected var FSell_Get_Func:Function = null;
      
      public function TNumenCellMvc()
      {
         super();
      }
      
      protected function AddEffect() : void
      {
         TGameUtil.setButtonMode(this.FBT_Get,true);
         TGameUtil.setButtonMode(this.FBT_Sell,true);
         this.FBT_Get.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FBT_Sell.addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBT_Get:
               if(this.FSell_Get_Func != null)
               {
                  this.FSell_Get_Func(this.FBloodFeteDat);
               }
               break;
            case this.FBT_Sell:
               if(this.FSell_Sell_Func != null)
               {
                  this.FSell_Sell_Func(this.FBloodFeteDat);
               }
         }
      }
      
      public function set Sell_Sell_Func(param1:Function) : void
      {
         this.FSell_Sell_Func = param1;
      }
      
      public function set Sell_Get_Func(param1:Function) : void
      {
         this.FSell_Get_Func = param1;
      }
      
      public function set Index(param1:int) : void
      {
         this.FIndex = param1;
      }
      
      public function get Index() : int
      {
         return this.FIndex;
      }
      
      public function set VISIBLE(param1:Boolean) : void
      {
         if(this.FThisPanel != null)
         {
            this.FThisPanel.visible = param1;
         }
      }
      
      public function get VISIBLE() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.FThisPanel != null)
         {
            _loc1_ = this.FThisPanel.visible;
         }
         return _loc1_;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      public function get FBFS() : TBloodFeteSingle
      {
         return this.FBloodFeteDat;
      }
      
      public function SetThisPanel(param1:MovieClip) : void
      {
         this.FBmp = new Bitmap();
         this.FThisPanel = param1;
         this.FT_Name = this.FThisPanel["FT_Name"];
         this.FBT_Get = this.FThisPanel["BT_Get"];
         this.FBT_Sell = this.FThisPanel["BT_Sell"];
         this.FMC_BloodFeteOne = this.FThisPanel["MC_BloodFeteOne"];
         this.FMC_BloodFeteOne.addChild(this.FBmp);
         this.AddEffect();
      }
      
      public function UpdateData(param1:TBloodFeteSingle) : void
      {
         this.FBT_Get.visible = true;
         this.FBT_Sell.visible = true;
         this.FBloodFeteDat = param1;
         if(this.FBloodFeteDat == null)
         {
            return;
         }
         this.FT_Name.text = this.FBloodFeteDat.Name;
         if(this.FBloodFeteDat.Type == 3)
         {
            this.FT_Name.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[6];
         }
         else
         {
            this.FT_Name.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[this.FBloodFeteDat.Quality];
         }
         this.FEffectId = this.FBloodFeteDat.EffectId;
         if(this.FBloodFeteDat.Type == 2)
         {
            this.FBT_Get.visible = false;
         }
         else if(this.FBloodFeteDat.Type == 4)
         {
            this.FBT_Sell.visible = false;
         }
         else if(this.FBloodFeteDat.Type == 3)
         {
            this.FBT_Sell.visible = false;
         }
         else
         {
            this.FBT_Get.visible = true;
         }
      }
      
      public function UpdateImage() : void
      {
         if(this.FEffectId == 0)
         {
            return;
         }
         TGameUtil.ShowAnimationByID(TGameUtil.Type_FollowBloodBound,this.FBmp,CONST_MODULES.MODULE_BloodFete,this.FEffectId);
      }
   }
}

